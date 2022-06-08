class PostsController < ApplicationController
  def index
    @user = @user = User.includes(posts: %i[comments likes]).find_by(id: params[:user_id])
    @posts = @user.posts
  end

  def show
    @user = current_user
    @post = Post.find_by(id: params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    user = current_user
    @post.author = user

    render :new unless @post.save

    redirect_to user_posts_path(user, @post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
