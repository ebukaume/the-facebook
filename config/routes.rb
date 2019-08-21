Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :user, except: [:index]

  resource :post do
    resources :comments, except: [:index, :new, :show]
    resource :likes, only: [:create, :destroy]
  end

  get ':user_id/friends', to: 'friends#index'
  
  root 'home#index'
end
