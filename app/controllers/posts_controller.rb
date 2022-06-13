class PostsController < ApplicationController
  def index
    return unless User.exists?(params[:user_id])

    @user = @user = User.includes(posts: %i[comments]).find_by(id: params[:user_id])
    @posts = @user.posts
  end

  def show
    return unless Post.exists?(params[:id])

    @user = current_user
    @post = Post.find_by(id: params[:id], author_id: params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    user = current_user
    @post.author = user

    if @post.author
      redirect_to user_posts_path(user, @post), notice: 'Post was successfully created!'
    else
      render :new
      flash[:error] = 'Post was not created, please try again later.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
