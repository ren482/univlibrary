Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: "toppages#index"
    
    get "academics", to: "toppages#academics"
    
    
    get "signup", to: "users#new"
    
    resources :users do
      member do
        get :auserreviews
        get :followings
        get :followers
      end
      collection do
        get :myreviews
        get :mybookshelf
        get :mypage
        
      end
    end
    
    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    
    resources :reviews, only: [:create, :destroy, :index, :new, :edit, :update] do
      member do
        get :new
        get :usersReviewsIndex
        
      end
    end
    
    resources :books do
      member do
        get :complete
        get :bookReviews
      end
    end
    

    
    resources :mybooks, only: [:create, :destroy]
   resources :relationships, only: [:create, :destroy]
    
end
