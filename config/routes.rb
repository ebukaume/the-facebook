Rails.application.routes.draw do
  devise_for :users, path: "",
   path_names: {
    sign_in: :login, 
    sign_up: :register, 
    sign_out: :logout
  }
  
  resource :post do
    resources :comments, except: [:index, :new, :show]
    resource :likes, only: [:create, :destroy]
  end

  get '/users', to: 'users#index'
  get '/friends', to: 'users#friends'
  get '/:id', to: 'users#show'
  
  root 'home#index'
end
