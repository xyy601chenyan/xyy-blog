Rails.application.routes.draw do
  devise_for :users
  root "articles#index"

  resources :articles do
    collection do
      get :search
    end
  end

  namespace :admin do
    resources :articles do
      member do
        post :publish
        post :sketch
        post :exclusive
      end
    end
  end

end
