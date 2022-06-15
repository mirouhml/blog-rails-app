# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Post
    can :read, User
    return unless user.present?

    can :create, Comment
    can :destroy, Comment, author_id: user.id
    can :manage, Post, author_id: user.id

    return unless user.admin?

    can :manage, :all
  end
end
