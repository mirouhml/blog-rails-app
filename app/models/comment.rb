class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def update_comments_counter(number)
    post.update(CommentsCounter: number)
  end
end
