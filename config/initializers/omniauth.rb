require 'rspotify/oauth'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"], scope: "playlist-read-private user-follow-read user-read-email"
end


=begin
playlist-read-private
user-follow-read
user-read-email
=end

