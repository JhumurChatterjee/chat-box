Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: :index do
    resources :messages, only: :index
  end

  resources :messages, only: :create

  post '/signup', to: 'users#create'
  post '/login',  to: 'sessions#create'

  get  '/auth',   to: 'home#authenticate'
end
