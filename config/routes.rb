Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  namespace "api" do
    post "auth/login", to: "auth#login"
    get "auth/reset_password_token", to: "auth#reset_password_token"
    patch "auth/reset_password", to: "auth#reset_password"
    post "auth/current", to: "auth#current"

    resources :announcements, only: %i[index]
    resources :courses, only: %i[index]

    resources :users, only: %i[] do
      get :current, on: :collection
    end

    namespace "admin" do
      resources :users
    end
  end
end
