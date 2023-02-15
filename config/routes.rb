Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'posts#index'

  resources :users, only: [:index, :show, :edit]
  resources :friendships, only: [:create, :index]
  resources :friend_requests, only: [:create, :index]
  resources :likings, only: [:create]
  resources :comments, only: [:create]
  resources :posts, only: [:index, :create, :show]
end
