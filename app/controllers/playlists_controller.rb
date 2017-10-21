require 'aws-sdk'

class PlaylistsController < ApplicationController

  def index
  #   RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
  #   # me = RSpotify::User.find('ryanmccool13')

  #   # me.playlists.each do |playlist|
  #   #   puts playlist.name
  #   # end
  #   # puts me.playlists[0].tracks.first.preview_url
  #   # puts me.playlists[0].tracks.first.album.images
  #   me = RSpotify::User.find('12122573728')
  #   playlist = me.playlists.first
  #   # puts playlist.tracks.count
  #   # puts playlist.name
  #   file = File.open("app/assets/mylist.txt", 'w') #{ |file| file.write("yourtext")}
  #   playlist.tracks.each do |track|
  #     if track.preview_url
  #       file.puts("file " + track.preview_url.to_s)
  #     end
  #   end
  #   file.close unless file.nil?

  #   system "ffmpeg -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i app/assets/mylist.txt -c copy this-should-be-new.mp3"
  # #   system "ffmpeg -i testoutput5.mp3 -c:a aac -b:a 128k output.m4a"
  # #   system "ffmpeg -loop 1 -i img.jpg -i output.m4a -c:v libx264 -c:a copy -shortest out2.mp4"

  # #  file_name = 'output3.mp3'
  #   file_name = 'this-should-be-new.mp3'

  #   s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
  #   obj = s3.bucket('dbc-team-samplify-test').object(file_name)
  #   puts "Uploading file #{file_name}"
  #   # / in front of app dir?
  #   obj.upload_file("#{file_name}")
  #   puts "Done"

  end

  # def send_simple_message
  #   begin
  #     RestClient.post ...
  #   rescue RestClient::ExceptionWithResponse => e
  #     puts e.response
  #   end
  # end

###############

  # def show
  #   file_name = 'output3.mp3'

  #   s3 = Aws::S3::Resource.new(region: ENV['AWS_REGION'])
  #   obj = s3.bucket('dbc-team-samplify-test').object(file_name)
  #   puts "Uploading file #{file_name}"
  #   obj.upload_file("/Users/apprentice/Desktop/#{file_name}")
  #   puts "Done"
  # end

  def destroy
    file_name = 'output3.mp3'
    File.delete("/Users/apprentice/Desktop/#{file_name}")
  end

# # Now you can access playlists in detail, browse featured content and more


# me.playlists #=> (Playlist array)

# # Find by id
# playlist = RSpotify::Playlist.find('guilhermesad', '1Xi8mgiuHHPLQYOw2Q16xv')
# playlist.name               #=> "d33p"
# playlist.description        #=> "d33p h0uz"
# playlist.followers['total'] #=> 1
# playlist.tracks             #=> (Track array)

# # Search by category
# party = RSpotify::Category.find('party')
# party.playlists #=> (Playlist array)
# categories = RSpotify::Category.list # See all available categories

# # Access featured content from Spotify's Browse tab
# featured_playlists = RSpotify::Playlist.browse_featured(country: 'US')
# new_releases = RSpotify::Album.new_releases(country: 'ES')

# # Access tracks' audio features
# sorry = RSpotify::Track.search("Sorry").first
# sorry.audio_features.danceability #=> 0.605
# sorry.audio_features.energy #=> 0.768
# sorry.audio_features.tempo #=> 100.209

# # Get recommendations
# recommendations = RSpotify::Recommendations.generate(seed_genres: ['blues', 'country'])
# recommendations = RSpotify::Recommendations.generate(seed_tracks: my_fav_tracks.map(&:id))
# recommendations = RSpotify::Recommendations.generate(seed_artists: my_fav_artists.map(&:id))
# recommendations.tracks #=> (Track array)

end
