require 'aws-sdk'

class PlaylistsController < ApplicationController

  def index
    RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])

    me = RSpotify::User.find('12122573728')
    playlist = me.playlists.first

    music_file = File.open("tmp/#{playlist.name}-mp3s.txt", 'w')
    image_file = File.open("tmp/#{playlist.name}-images.txt", 'w')

    playlist.tracks.each do |track|
      if track.preview_url
        music_file.puts("file " + track.preview_url.to_s)
      end
      if track.album.images
        IO.copy_stream(open("#{track.album.images[0]["url"]}"), "tmp/#{track.id}.jpg")
        image_file.puts("file '#{track.id}.jpg'")
        image_file.puts("duration 30")
      end
    end

    music_file.close unless music_file.nil?
    image_file.close unless image_file.nil?

    system "ffmpeg -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{playlist.name}-mp3s.txt -c copy tmp/keepItSimple.mp3"

    system "ffmpeg -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i tmp/#{playlist.name}-images.txt -i tmp/keepItSimple.mp3 -c:a aac -b:a 128k -c:v libx264 tmp/#{playlist.name}-sampler.mp4"

    File.delete("tmp/#{playlist.name}-mp3s.txt")
    File.delete("tmp/#{playlist.name}-images.txt")

    @file_name= "#{playlist.name}-sampler.mp4"

    s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    obj = s3.bucket('dbc-team-samplify-test').object(@file_name)
    puts "Uploading file #{@file_name}"
    obj.upload_file("tmp/#{@file_name}")
    puts "Done"

    File.delete("tmp/#{@file_name}")
    File.delete("app/assets/images/#{@file_name}")
    puts "Has been deleted"
  end

  def show
    # file_name= 'secondAttempt.mp4'

    # s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
    # obj = s3.bucket('dbc-team-samplify-test').object(@file_name)
    # puts "Uploading file #{@file_name}"
    # obj.upload_file("app/assets/images/#{@file_name}")
    # puts "Done"
  end

  def destroy
    file_name = 'output3.mp3'
    File.delete("/Users/apprentice/Desktop/#{file_name}")
  end

end
