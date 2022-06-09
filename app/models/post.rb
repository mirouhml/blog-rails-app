class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :title, presence: true, length: { maximum: 250 }
  validates :CommentsCounter, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :LikesCounter, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def update_posts_counter(number)
    author.update(PostsCounter: number)
  end

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end
end
