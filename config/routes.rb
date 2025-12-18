Rails.application.routes.draw do

  # Defines the root path route ("/")
  root "search#index"

  get "search/index", to: "search#index"
  get "search/results", to: "search#results"

  get "up" => "rails/health#show", as: :rails_health_check

  get "/file", to: "search#file"
end
