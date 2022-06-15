class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    return unless User.exists?(params[:user_id])

    @user = User.includes(posts: %i[comments]).find_by(id: params[:user_id])
    @posts = @user.posts
  end

  def show
    return unless Post.exists?(params[:id])

    @user = current_user
    @post = Post.find_by(id: params[:id], author_id: params[:user_id])
    @like = Like.exists?(post_id: @post.id, author_id: @user.id)
  end

  def new
    @post = Post.new
    id = params[:user_id].to_i
    return unless current_user.id != id

    message = "You don't have permission to create a post here. Please go to your profile page to create a post."
    authorize! :add, @post, message:
  end

  def create
    user = current_user
    @post = Post.new(post_params)
    @post.author = user
    if @post.save
      user.PostsCounter += 1
      user.save
      redirect_to user_posts_path(user, @post), notice: 'Post was successfully created!'
    else
      render :new
      flash[:alert] = 'Post was not created, please try again later.'
    end
  end

  def destroy
    user = current_user
    @post = Post.find_by(id: params[:id], author_id: params[:user_id])
    like = Like.find_by(post_id: @post.id, author_id: params[:user_id])
    if like.destroy
      if @post.destroy
        user.PostsCounter -= 1
        user.save
        flash[:notice] = 'Post deleted!'
      else
        flash[:alert] = 'Post was not deleted, please try again later.'
      end
    end
    redirect_to user_posts_path(user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
