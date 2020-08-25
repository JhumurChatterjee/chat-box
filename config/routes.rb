Rails.application.routes.draw do
  root "home#index"

  post "/signup", to: "users#create"
  post "/login",  to: "sessions#create"

  get  "/auth",   to: "home#authenticate"
end
