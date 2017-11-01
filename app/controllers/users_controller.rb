class UsersController < ApplicationController

  def index
  end

  def spotify
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    user = User.find_or_create_by(display_name: spotify_user.display_name, email: spotify_user.email, spotify_id: spotify_user.id, profile_pic_url: spotify_user.images[0][:url])
    session[:user_id] = spotify_user.id
    redirect_to user_path(current_user)
  end

  def show
    @user = User.find(params[:id])
    @spotify_user = RSpotify::User.find(@user.spotify_id)
  end
end
