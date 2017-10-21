class UsersController < ApplicationController

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # p spotify_user.name
    p spotify_user.to_hash
    # redirect_to root_path
  end

end