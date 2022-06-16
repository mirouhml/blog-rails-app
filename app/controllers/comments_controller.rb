class CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    json_response(@comments)
  end

  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    post_author = post.author

    @comment = Comment.new(comment_params)
    @comment.post = post
    @comment.author = current_user

    if @comment.save
      post.CommentsCounter += 1
      post.save
      json_response(@comment, :created)
      redirect_to user_post_url(post_author, post), notice: 'Comment was successfully registered!'
    else
      render :new
      flash[:alert] = 'Comment was not registered, please try again later.'
    end

  end

  def destroy
    @comment = Comment.find(params[:id])
    author = @comment.post.author
    post = @comment.post
    if @comment.destroy
      post.CommentsCounter -= 1
      post.save
      flash[:notice] = 'Comment deleted!'
    else
      flash[:alert] = 'Comment was not deleted, please try again later.'
    end
    redirect_to user_post_url(author, post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
