Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }
  # get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  patch 'products/update_stock/:id',to: 'products#update_stock'
  patch 'user/balance/:id',to: 'user#topup'
  get 'user/profile',to: 'user#profile', :as => :profile
  get 'user/shop',to: 'user#shop', :as => :shop
  get 'user/profile/:id',to: 'user#edit_profile', :as => :edit_profile
  get 'user/shop/:id',to: 'user#edit_shop', :as => :edit_shop
  
  resources :home do
    member do
       get 'p'
    end
  end
  # http://localhost:3000/category/2

  # devise_scope :user do
  #   # using login path for registration
  #   get '/login' => 'registrations#new', :as => :new_user_registration
  #   post '/signup' => 'registrations#create', :as => :user_registration
  #   post '/signin' => 'sessions#create', :as => :user_session
  # end

 resources :products
 resources :user do
  member do
    get 'profile'
  end
 end


 resources :sales
 resources :addresses

  resources :carts
  resources :orders do
    collection do
      get 'transaction'
    end
  end

  root "home#index"
   # Handing error no route match
   match "*path", to: "application#error_404", via: :all

end
