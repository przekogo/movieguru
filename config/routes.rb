Rails.application.routes.draw do
  devise_for :users

  root 'home#welcome'
  resources :genres, only: :index do
    member do
      get 'movies'
    end
  end
  resources :movies, only: [:index, :show] do
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
  namespace :api, path: '', constraints: {subdomain: 'api'}, defaults: {format: :json} do
    namespace :v1 do
      resources :movies
    end
    namespace :v2 do
      resources :movies
    end
  end
  post 'movies/get_moviedb_data', to: 'movies#get_moviedb_data'
end
