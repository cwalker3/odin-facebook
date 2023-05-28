Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'posts#index' 

  resources :profiles, only: [:index, :show, :edit, :update]
  resources :friendships, only: [:create, :index]
  resources :friend_requests, only: [:create, :index]
  resources :likings, only: [:create]
  resources :comments, only: [:create]
  resources :posts, only: [:index, :create, :show]

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
end
