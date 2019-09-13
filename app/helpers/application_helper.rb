# frozen_string_literal: true

module ApplicationHelper
  include HomeHelper

  def app_name
    'The Facebook'
  end

  def page_title
    return "#{app_name} | #{current_user.fullname}" if user_signed_in?

    "#{app_name} - log in or sign up"
  end

  def image_src_for(user, size: '')
    "#{user.image}?s=#{size}"
  end

  def submit_button_label(item)
    item.new_record? ? item.class : 'Save'
  end

  def count(array, collection_of)
    return if (count_of = array.size).zero?

    pluralize(count_of, collection_of)
  end

  def authored_by_current_user(resource)
    resource.author == current_user
  end

  def liked?(likeable)
    likeable.likes.any? { |like| like.liker == current_user }
  end

  def edited?(resource)
    resource.updated_at > resource.created_at
  end

  def normalize_comment_for_edit(comment, post)
    return comment if comment.post == post

    Comment.new
  end

  def user_friendship_request(user, dir = :sent)
    sender = current_user
    receiver = user
    sender, receiver = receiver, sender if dir == :received

    sender.friendships.where(friend: receiver).first
  end

  def friend_requests
    Friendship.pending_requests current_user
  end

  def friends(user)
    Friendship.confirmed_friends(user)
  end
end
