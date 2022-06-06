class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, :class_name => 'User', :foreign_key => 'author_id'

  def update_comments_counter(number)
    post.update(CommentsCounter: number)
  end
end
