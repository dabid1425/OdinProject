Rails.application.routes.draw do
  root "products#index"
  # to make things easier we can do all routes below
  resources :products

  # alternatively we can make the routes as such
  # get "/products", to: "products#index"
  #
  # get "/products/new", to: "products#new"
  # post "/products", to: "products#create"
  #
  # get "/products/:id", to: "products#show"
  #
  # get "/products/:id/edit", to: "products#edit"
  # patch "/products/:id", to: "products#update"
  # put "/products/:id", to: "products#update"
  #
  # delete "/products/:id", to: "products#destroy"

end
