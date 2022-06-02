Rails.application.routes.draw do
  resources :users, only: [:index] do
    resources :posts, only: [:index]
  end
end
