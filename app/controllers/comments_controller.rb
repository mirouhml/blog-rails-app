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

    render :new unless @comment.save

    redirect_to user_post_url(post_author, post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
