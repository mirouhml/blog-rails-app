class ApiController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :authenticate_user!

  include Response

  def list_all_user_posts
    authentication_token = params[:authentication_token]
    return unless check_token_user_params(authentication_token)

    posts = Post.where(author_id: params[:user_id])
    json_response(posts)
  end

  def list_all_user_post_comments
    authentication_token = params[:authentication_token]
    return unless check_token_user_params(authentication_token)

    comments = Comment.where(post_id: params[:post_id])

    json_response(comments)
  end

  def add_comment
    authentication_token = params[:authentication_token]
    return unless check_token_user_params(authentication_token)

    post_id = params[:post_id]
    text = params[:text]
    return unless check_post_comment_params(text)

    comment = Comment.new(text:, author: @current_user, post_id:)
    if comment.save
      json_response(comment, 200)
    else
      json_response({ error: 'Comment was not created, please try again later.' }, 500)
    end
  end

  private

  def check_post_comment_params(text)
    json_response({ error: 'Post does not exist.' }, 404) && false unless Post.exists?(params[:post_id])

    json_response({ error: 'Comment text is empty.' }, 400) && false if text.nil? || text.empty?

    true
  end

  def check_token_user_params(authentication_token)
    json_response({ error: 'Invalid token.' }, 400) && false if authentication_token.nil?

    json_response({ error: 'Not authorized.' }, 401) && false unless authenticate(authentication_token)

    json_response({ error: 'User does not exist.' }, 404) && false unless User.exists?(params[:user_id])

    true
  end

  def authenticate(authentication_token)
    email = ApiHelper::JsonWebToken.decode(authentication_token)[0]
    user = User.find_by(email:)
    return false if user.nil?

    @current_user = user
    true
  end
end
