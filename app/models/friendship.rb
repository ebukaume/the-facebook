# frozen_string_literal: true

class Friendship < ApplicationRecord
  self.primary_key = 'id'

  before_create { self.id = user.id + friend.id }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :confirmed_friends, -> { where(confirmed: true).map(&:friend) }
  scope :pending_friends, -> { where(confirmed: false).map(&:friend) }
  scope :pending_inverse, -> { where(confirmed: false).map(&:user) }

  default_scope -> { includes(:user, :friend) }

  def self.mutual(other_user)
    # where()
  end

  def self.delete_friendship(user, friendship_id)
    friendship = find_by(id: friendship_id)
    return 'Sorry, such friendship does not exist!' if friendship.nil?
    return 'Sorry, you are not authorized to perform this action!' unless friendship.has?(user)

    if friendship.confirmed?
      where(user: friendship.user, friend: friendship.friend)
        .or(where(user: friendship.friend, friend: friendship.user))
        .destroy_all
    else
      friendship.destroy
    end

    'Friendship successfully terminated!'
  end

  def self.confirm_friendship(user, friendship_id)
    friendship = find_by(id: friendship_id)
    return 'Sorry, such friendship does not exist!' if friendship.nil?
    return 'Sorry, you are not authorized to perform this action!' unless friendship.friend == user
    return 'Sorry, this friendship has already been confirmed' if friendship.confirmed?

    Friendship.transaction do
      friendship.update(confirmed: true)
      user.friendships.create(friend: friendship.user, confirmed: true)
      return "You are now friends with #{friendship.user.fullname}"
    end

    'Something went wrong!'
  end

  def has?(other_user)
    [user, friend].include? other_user
  end
end
