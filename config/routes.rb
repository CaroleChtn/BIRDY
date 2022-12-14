Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  get 'dashboards', to: 'pages#dashboard'
  get 'myprofile', to: 'pages#myprofile'
  post 'update_profile', to: 'pages#update_profile', as: 'update_profile'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :missions, only: [:index, :show] do
    resources :bookings, only: [:show, :create, :update, :edit]
  end

  resources :bookings, only: [:destroy]
  patch 'change_category', to: 'pages#change_category'

  resources :missions, only: [:index, :show] do
    resources :favorites, only: [:create]
  end

  resources :favorites, only: :destroy

  resources :chatrooms, only: [:show, :new, :create] do
    resources :messages, only: :create
  end
end
