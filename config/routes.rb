Rails.application.routes.draw do
  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Root → Signup
  root "users#new"

  # Signup
  get  "/signup", to: "users#new",    as: :signup
  post "/signup", to: "users#create"

  # Login / Logout
  get    "/login",  to: "sessions#new",     as: :login
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # Email verification
  get "/verify-email", to: "email_verifications#update", as: :verify_email

  # Dashboard (after login)
  get "/dashboard", to: "dashboard#index", as: :dashboard

  # Kudos
  resources :kudos, only: [:new, :create]
end
