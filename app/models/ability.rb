class Ability
  include CanCan::Ability

  def initialize(_user)
    user ||= User.new # guest user (not logged in)

    can :read, :all

    return unless user.present?

    can :create, Comment
    can :create, Like
    can :destroy, Comment, author_id: user.id
    can :destroy, Like, author_id: user.id
    can :manage, Post, author_id: user.id

    return unless user.admin?

    can :manage, :all
  end
end
