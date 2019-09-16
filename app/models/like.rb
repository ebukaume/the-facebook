# frozen_string_literal: true

class Like < ApplicationRecord
  self.primary_key = 'id'

  belongs_to :likeable, polymorphic: true
  belongs_to :liker, class_name: 'User'

  default_scope -> { includes(:liker) }

  def self.like_resource(resource, user)
    return 'Sorry, you are not authorized to like this resource.' unless can_like?(resource.author, user)
    return if resource.likes.create(liker: user)

    'Something went wrong'
  end

  def self.unlike_resource(resource, user)
    return 'Sorry, but you never liked this resource!' unless (like = can_unlike?(resource, user))
    return if like.destroy

    'Something went wrong'
  end

  def self.can_like?(resource_author, user)
    resource_author == user || resource_author.friends_with?(user)
  end

  def self.can_unlike?(resource, user)
    resource.likes.filter { |like| like.liker == user }.first
  end
end
