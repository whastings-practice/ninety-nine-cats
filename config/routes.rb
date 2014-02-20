NinetyNineCats::Application.routes.draw do

  root to: 'cats#index'

  resources :cats

  resources :cat_rental_requests, only: [:new, :create] do
    member do
      patch 'approve'
      patch 'deny'
    end
  end

  resources :users, only: [:new, :create]

  resource :session, only: [:new, :create, :destroy]

end
