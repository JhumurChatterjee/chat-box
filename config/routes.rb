Rails.application.routes.draw do
  root 'home#index'

  resources :users, only: :index
  resources :messages, only: %i[index create]

  post '/signup', to: 'users#create'
  post '/login',  to: 'sessions#create'

  get  '/auth',   to: 'home#authenticate'
end
