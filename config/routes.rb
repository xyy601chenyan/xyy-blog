Rails.application.routes.draw do
  devise_for :users
  root "articles#index"

  resources :articles do
    collection do
      post :search
    end
  end

  namespace :admin do
    resources :articles
  end

end
