class LikesController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    user = current_user
    liked = Like.where(author: user, post:)

    return if liked.present?

    like = Like.create(author: user, post:)
    return unless like.save

    redirect_to user_post_path(post.author, post)
  end
end
