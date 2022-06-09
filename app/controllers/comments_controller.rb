class CommentsController < ApplicationController
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
      redirect_to user_post_url(post_author, post), notice: 'Comment was successfully registered!'
    else
      render :new
      flash[:alert] = 'Comment was not registered, please try again later.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
