Rails.application.routes.draw do
  devise_for :users
  # get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "home#index"
  patch 'products/update_stock/:id',to: 'products#update_stock'
  
  resources :home do
    member do
       get 'p'
    end
 end

 resources :products
 resources :user
 resources :sales

  resources :carts
  resources :orders do
    collection do
      get 'transaction'
    end
  end

 

end
