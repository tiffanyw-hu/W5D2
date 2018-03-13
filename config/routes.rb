Rails.application.routes.draw do

  resources :posts, only: [:edit, :update, :show, :destroy]
  resources :subs do
    resources :posts, only: [:new, :create]
  end
  resources :users
  resource :session, only: [ :new, :create, :destroy ]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
