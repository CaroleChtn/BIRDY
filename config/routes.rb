Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get 'dashboards', to: 'pages#dashboard'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :missions, only: [:index, :show] do
    resources :bookings, only: [:show, :create, :update, :edit]
  end
  resources :bookings, only: [:destroy]
end
