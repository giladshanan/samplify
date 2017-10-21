require 'aws-sdk'

class PlaylistsController < ApplicationController

  def index
# RSpotify.authenticate(ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"])
#     # me = RSpotify::User.find('ryanmccool13')

#     # me.playlists.each do |playlist|
#     #   puts playlist.name
#     # end
#     # puts me.playlists[0].tracks.first.preview_url
#     # puts me.playlists[0].tracks.first.album.images
#     me = RSpotify::User.find('12122573728')
#     # Test playlist
#     playlist = me.playlists.first
#     # Verify 10 tracks:
#     puts playlist.tracks.count
#     # print name to console
#     puts playlist.name

#     music_file = File.open("app/assets/images/#{playlist.name}-mp3s.txt", 'w') #{ |file| file.write("yourtext")}
#     image_file = File.open("app/assets/images/#{playlist.name}-images.txt", 'w') #{ |file| file.write("yourtext")}

#     playlist.tracks.each do |track|
#       if track.preview_url
#         music_file.puts("file " + track.preview_url.to_s)
#       end
#       if track.album.images
#         image_file.puts("file '#{track.album.images[0]["url"]}'")
#         image_file.puts("duration 30")
#       end
#     end
#     image_file.puts("file '#{playlist.tracks.last.album.images[0]["url"]}'")
#     music_file.close unless music_file.nil?
#     image_file.close unless image_file.nil?

#     # system "ffmpeg -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i app/assets/mylist.txt -c copy testoutput5.mp3"
#   #   system "ffmpeg -i testoutput5.mp3 -c:a aac -b:a 128k output.m4a"
#   #   system "ffmpeg -loop 1 -i img.jpg -i output.m4a -c:v libx264 -c:a copy -shortest out2.mp4"

#     system "ffmpeg -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i app/assets/images/#{playlist.name}-mp3s.txt -c copy app/assets/images/keepItSimpleStupid.mp3"
#     system "ffmpeg -f concat -safe 0 -protocol_whitelist 'file,http,https,tcp,tls' -i app/assets/images/#{playlist.name}-images.txt -i app/assets/images/keepItSimpleStupid.mp3 -c:a aac -b:a 128k -c:v libx264 app/assets/images/firstAttempt.mp4"
#     # system "ffmpeg -i seventhAttempt.mp4 eighthMix.mp4"
#     File.delete("app/assets/images/#{playlist.name}-mp3s.txt")
#     File.delete("app/assets/images/#{playlist.name}-images.txt")

  end

  # def send_simple_message
  #   begin
  #     RestClient.post ...
  #   rescue RestClient::ExceptionWithResponse => e
  #     puts e.response
  #   end
  # end

###############

  def show
    # p session[:user_id]
    spotify_user = RSpotify::User.find(session[:user_id])
    @playlists = spotify_user.playlists
    @playlists.each_with_index do |playlist, index|
      if playlist.id == params[:id]
        @playlist = playlist
      end
    end
    # @playlist = spotify_user.playlists.first
    @tracks = @playlist.tracks
    # @playlists = spotify_user.playlists
    # @playlists.find_index(@playlist)
    #current_user
  end

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
