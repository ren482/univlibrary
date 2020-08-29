Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: "toppages#index"
    
    get "academics", to: "toppages#academics"
    
    
    get "signup", to: "users#new"
    get "mypage", to: "users#mypage"
    resources :users
    
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
end
