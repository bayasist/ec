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
    get "shipping_and_payment"
    post "shipping_address"
    post "payment_method"
  end

  resources :purchases do
    member do
      get "finish"
    end
  end

  namespace :mypage do
    resources :payment_methods
  end

  namespace :admin do
    get "/", to: "home#index"
    resources :admin_users do
      collection do
        get "sign_in"
        post "sign_in"
        get "sign_out"
      end
    end
    resources :selling_products do
    end
  end
end
