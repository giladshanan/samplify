class SamplersController < ApplicationController

  def new
    @spotify_user = RSpotify::User.find(session[:user_id])
    @playlists = @spotify_user.playlists
    @playlists.each do |playlist|
      if playlist.id == params[:id]
        @playlist = playlist
      end
    end
    @user = User.find_by(spotify_id: session[:user_id])
    @sampler = Sampler.find_or_create_by(user_id: @user.id, title: @playlist.name, spotify_url: @playlist.external_urls["spotify"], samplified: false)
    session[:playlist_id] = @playlist.id

    if @sampler.tracks.empty?
      @playlist.tracks.each do |track|
        @track = Track.create(name: track.name, artist: track.artists[0].name, album: track.album.name, preview_url: track.preview_url, image: track.album.images[0]["url"], sampler_id: @sampler.id)
      end
    else
      @sampler.tracks.each_with_index do |track, index|
        track.image = @playlist.tracks[index].album.images[0]["url"]
        track.save
      end
    end
    @tracks = @sampler.tracks
  end

  def update
    @sampler = Sampler.find_by(id: params[:id])
    MakeDownloadSamplerJob.perform_async(@sampler.id)
    redirect_to sampler_path(@sampler)
  end

  def show
    @spotify_user = RSpotify::User.find(session[:user_id])
    @playlists = @spotify_user.playlists
    @playlists.each do |playlist|
      if playlist.id == session[:playlist_id]
        @playlist = playlist
      end
    end
    @sampler = Sampler.find_by(id: params[:id])
  end

  ################################################
  # This is the original code that makes video concat
  # work on localhost. Won't work on heroku as it does
  # not use a background process. Holding on to it
  # in order to ensure we have working code for local.
  ################################################
  # def update
  #   @sampler = Sampler.find_by(id: params[:id])

    # This is the no good code that shouldn't be in final:
    # music_file = File.open("tmp/#{@sampler.id}-mp3s.txt", 'w')
    # image_file = File.open("tmp/#{@sampler.id}-images.txt", 'w')
    # @sampler.tracks.each do |track|
    #   if track.preview_url
    #     music_file.puts("file " + track.preview_url.to_s)
    #     ################################
    #     # This might work:
    #     image_file.puts("file https:#{track.image.url(:original)}")
    #     image_file.puts("duration 30")
    #   end
    # end
    # music_file.close unless music_file.nil?
    # image_file.close unless image_file.nil?

    # system "ffmpeg -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-mp3s.txt -c copy tmp/keepItSimple.mp3"
    # p '*************************************'
    # p 'After audio creation'
    # p '*************************************'
    # ########################################
    # # This is the high-qual vid codec
    # ########################################
    # system "ffmpeg -loglevel 56 -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-images.txt -c:v libx264 simpleVideo.mp4"

    # ########################################
    # # This is the low-qual vid codec
    # ########################################
    # # system "ffmpeg -loglevel 56 -y -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{@sampler.id}-images.txt -c:v mpeg4 simpleVideo.mp4"
    # p '*************************************'
    # p 'After video creation'
    # p '*************************************'

    # system "ffmpeg -y -i tmp/keepItSimple.mp3 -i simpleVideo.mp4 -c:v libx264 -c:a aac tmp/#{@sampler.id}-sampler.mp4"

    # @file_name= "#{@sampler.id}-sampler.mp4"
    # p '*************************************'
    # p 'After combination'
    # p @file_name
    # p '*************************************'
    # s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    # obj = s3.bucket('dbc-team-samplify-test').object(@file_name)

    # puts "Uploading file #{@file_name}"
    # obj.upload_file("tmp/#{@file_name}")
    # @sampler.samplified = true
    # @sampler.s3_url = "https://s3.us-east-2.amazonaws.com/dbc-team-samplify-test/#{@file_name}"
    # @sampler.save
    # p '************************************'
    # puts "Done"
    # p session[:playlist_id]
    # p session[:user_id]
    # p '************************************'
  #   redirect_to sampler_path(@sampler)
  # end

end
