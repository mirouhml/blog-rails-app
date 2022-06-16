Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: :sessions },
                     path_names: { sign_in: :login }
  resources :users, only: %i[index show update] do
    resources :posts, only: %i[index show new create destroy] do
      resources :comments, only: %i[index new create destroy]
      resources :likes, only: %i[create destroy]
    end
  end

  root to: 'users#index'
end
