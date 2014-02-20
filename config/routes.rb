NinetyNineCats::Application.routes.draw do

  resources :cats

  resources :cat_rental_requests, only: [:new, :create] do
    member do
      patch 'approve'
      patch 'deny'
    end
  end

  resources :users, only: [:new, :create]

end
