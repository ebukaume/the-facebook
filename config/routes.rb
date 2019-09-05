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

  resources :posts, only: %i[create edit update destroy]
  resources :comments, except: %i[index new show]
  resources :likes, only: %i[create destroy]

  get '/friends', to: 'users#friends'

  root 'home#index'
end
