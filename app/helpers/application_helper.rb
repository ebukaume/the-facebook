# frozen_string_literal: true

module ApplicationHelper
  include HomeHelper

  def app_name
    'The Facebook'
  end

  def image_src_for(user, size: '')
    "#{user.image}?s=#{size}"
  end

  def count(array, collection_of)
    return if (count_of = array.size).zero?

    pluralize(count_of, collection_of)
  end

  def liked?(likeable)
    likeable.likes.any? { |like| like.liker == current_user }
  end
end
