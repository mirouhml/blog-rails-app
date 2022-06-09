class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :author, presence: true
  validates :post, presence: true
  validates :text, presence: true

  def update_comments_counter(number)
    post.update(CommentsCounter: number)
  end
end
