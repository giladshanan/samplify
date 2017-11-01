class SamplersController < ApplicationController

  def new
    spotify_user = RSpotify::User.find(session[:user_id])
    playlists = spotify_user.playlists
    @playlist = playlists.find { |playlist| playlist.id == params[:id] }
    user = User.find_by(spotify_id: session[:user_id])
    @sampler = Sampler.find_or_create_by(user_id: user.id, title: @playlist.name, spotify_url: @playlist.external_urls["spotify"])
    session[:playlist_id] = @playlist.id
    if @sampler.tracks.empty?
      @playlist.tracks.take(10).each do |track|
        Track.create(name: track.name, artist: track.artists[0].name, album: track.album.name, preview_url: track.preview_url, image: track.album.images[0]["url"], sampler_id: @sampler.id)
      end
    end
    @tracks = @sampler.tracks.order("created_at ASC")
    @message = "Sorry, Spotify doesn't have a preview available for this song."
  end

  def update
    @sampler = Sampler.find_by(id: params[:id])
    MakeDownloadSamplerJob.perform_async(@sampler.id)
    redirect_to sampler_path(@sampler)
  end

  def show
    @sampler = Sampler.find_by(id: params[:id])
    @tracks = []
    music_file = File.open("tmp/#{@sampler.id}-show-mp3s.txt", 'w')
    @sampler.tracks.order("created_at ASC").each do |track|
      if track.preview_url
        @tracks << track
        music_file.puts("file " + track.preview_url.to_s)
      end
    end
    music_file.close unless music_file.nil?
    system "ffmpeg -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-show-mp3s.txt -c copy tmp/#{@sampler.id}.mp3"
    file_name = "#{@sampler.id}.mp3"
    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    obj = s3.bucket('dbc-team-samplify-test').object(file_name)
    obj.upload_file("tmp/#{file_name}")
  end

  def check
    @sampler = Sampler.find(params[:id])
    if request.xhr? && @sampler.samplified
      render "_download", layout: false
    end
  end

end
