# frozen_string_literal: true

class Friendship < ApplicationRecord
  self.primary_key = 'id'

  before_create { self.id = user.id + friend.id }

  belongs_to :user
  belongs_to :friend, class_name: 'User'

  scope :confirmed, -> { where(confirmed: true) }
  scope :pending, -> { where(confirmed: false) }

  default_scope -> { includes(:user, :friend) }

  def self.mutual_friends(user, other_user)
    find_by_sql(["SELECT friendships.*
                  FROM friendships
                  WHERE friendships.user_id = ?
                  AND friendships.friend_id
                  IN ( SELECT friendships.friend_id
                        FROM friendships
                        WHERE friendships.user_id = ?
                        AND confirmed = TRUE
                      );", user.id, other_user.id])
      .map(&:friend)
  end

  def self.confirmed_friends(user)
    confirmed.where(user: user).map(&:friend)
  end

  def self.pending_friends(user)
    pending.where(user: user).map(&:friend)
  end

  def self.pending_requests(user)
    pending.where(friend: user).map(&:user)
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

    transaction do
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
