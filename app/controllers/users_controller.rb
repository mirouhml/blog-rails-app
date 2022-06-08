class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    return unless User.exists?(params[:id])

    @user = User.includes(posts: %i[comments likes]).find_by(id: params[:id])
    @recent_posts = @user.recent_posts
  end
end
