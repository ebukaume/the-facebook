Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :index]

  # devise_for :users, path: "",
  #  path_names: {
  #   sign_in: :login, 
  #   sign_up: :register, 
  #   sign_out: :logout
  # }
  
  resources :posts, only: [:create, :edit, :update, :destroy]
  resources :comments, except: [:index, :new, :show]
  resources :likes, only: [:create, :destroy]


  get '/friends', to: 'users#friends'
  
  root 'home#index'
end
