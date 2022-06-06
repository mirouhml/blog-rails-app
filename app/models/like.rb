class Like < ApplicationRecord
  belongs_to :post
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'

  def update_likes_counter(number)
    post.update(LikesCounter: number)
  end
end
