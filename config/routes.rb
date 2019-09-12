# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show index]

  # devise_for :users, path: "",
  #  path_names: {
  #   sign_in: :login,
  #   sign_up: :register,
  #   sign_out: :logout
  # }

  resources :posts, only: %i[index create edit update destroy]
  resources :comments, except: %i[index new show]
  resources :likes, only: %i[create destroy]
  resources :friendships, only: %i[create update destroy]

  get '/friends', to: 'friendships#index'
  get '/:user/friends', to: 'friendships#user_friends'
  get '/friend_requests', to: 'friendships#requests'
  get '/friend_requests_sent', to: 'friendships#requests_sent'

  root 'home#index'
end
