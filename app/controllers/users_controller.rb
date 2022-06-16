class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    json_response(@users)
  end

  def show
    return unless User.exists?(params[:id])

    @user = User.find_by(id: params[:id])
    @recent_posts = @user.recent_posts
  end

  def update
    if current_user.update_attributes(user_params)
      render :show
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :bio, :image)
  end
end
