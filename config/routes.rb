Rails.application.routes.draw do

  resources :users
  resources :tracks

  root "playlists#index"

  # get "/playlists/show" => "playlists#show"

  get "/playlists/delete" => "playlists#destroy"

  get "/playlists/:id/show" => "playlists#show", as: :playlist

  get "/auth/spotify/callback", to: 'users#spotify'

  delete "/logout", to: "sessions#destroy", as: :logout

end
