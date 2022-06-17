class UsersController < ApplicationController
  def index
    @users = User.all
    json_response(@users)
  end

  def show
    return unless User.exists?(params[:id])

    @user = User.find_by(id: params[:id])
    @recent_posts = @user.recent_posts
  end
end
