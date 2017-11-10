Rails.application.routes.draw do
  devise_for :users
  root "articles#index"

  resources :articles do
    collection do
      get :search
      get :ror_page
      get :tutorial_page
      get :growth_page
      get :life_page
    end
    resources :comments
  end

  namespace :admin do
    resources :articles do
      member do
        post :publish
        post :sketch
        post :exclusive
        post :move_to_top
      end
      collection do
        get :find
        get :ror_page1
        get :tutorial_page1
        get :growth_page1
        get :life_page1
      end
    end
  end

end
