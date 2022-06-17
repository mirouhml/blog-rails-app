Rails.application.routes.draw do
  get 'users/:author_id/show', to: 'api#show_users_posts', as: 'api_show_posts'
  get 'posts/:post_id/comments', to: 'api#show_posts_comments', as: 'api_show_comments'
  post 'posts/:post_id/comments', to: 'api#add_comment_to_post', as: 'api_add_comment'
  devise_for :users
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create, :destroy]
    end
  end

  root to: 'users#index'
end
