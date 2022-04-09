Rails.application.routes.draw do
  devise_for :members
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "top#index"

  resources :product_classes do
  end
  resource :cart do
    post "add/:code", to: "carts#add", as: :add
    delete "delete/:code", to: "carts#delete", as: :delete
  end
end
