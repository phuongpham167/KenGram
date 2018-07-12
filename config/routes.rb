Rails.application.routes.draw do

  get "sessions/new"
  root "static_pages#home"
  get "/help", to: "static_pages#help"
  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :users do
    member do
      get :user_like, :user_bookmark, :followings, :followers
    end
  end

  resources :posts do
    member do
      get :post_like, :followings, :followers
    end
  end

  resources :post_attachments
  resources :albums
  resources :posts
  resources :likes, only: [:create, :destroy]
  resources :bookmarks, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :post_comments
end
