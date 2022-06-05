class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def update_likes_counter(number)
    post.update(LikesCounter: number)
  end
end