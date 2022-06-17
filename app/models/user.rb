class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :PostsCounter, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_save :add_token

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  ROLES = %i[admin default].freeze

  def admin?
    is? :admin
  end

  def is?(requested_role)
    role == requested_role.to_s
  end

  def add_token
    update_column(:token, ApiHelper::JsonWebToken.encode(email))
  end
end
