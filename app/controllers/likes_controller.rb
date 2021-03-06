class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    user = current_user
    liked = Like.where(author: user, post:)

    if liked.present?
      flash[:notice] = 'Post already liked'
    else
      like = Like.create(author: user, post:)
      if like.save
        post.LikesCounter += 1
        post.save
        redirect_to user_post_path(post.author, post), notice: 'Post successfully liked'
      else
        flash[:alert] = 'Could not like the post, please try again later.'
      end
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    user = current_user
    like = Like.find_by(post_id: post.id, author_id: user.id)

    if like.destroy
      post.LikesCounter -= 1
      post.save
      redirect_to user_post_path(post.author, post), notice: 'Post successfully unliked'
    else
      flash[:alert] = 'Could not unlike the post, please try again later.'
    end
  end
end
