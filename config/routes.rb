Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  #
  # Defines the root path route ("/")
  get "/", to: "static_pages#index"
  post "/:id", to: "static_pages#search"
  get "/:id", to: "static_pages#show"
  root "static_pages#index"
end
