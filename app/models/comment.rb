# frozen_string_literal: true

class Comment < ApplicationRecord
  self.primary_key = 'id'
  validates :content, presence: true

  belongs_to :author, class_name: 'User'
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  default_scope -> { order('created_at').includes(:author, :likes) }

  def can_edit?(user)
    authored_by?(user)
  end

  def update_comment(user, params)
    if can_edit?(user)
      if update_attributes(params)
        'Comment successfuly edited!'
      else
        'Oops! Please make sure the content is at least 2 character long!'
      end
    else
      "Sorry, you can't delete this comment. You are not the author!"
    end
  end

  def delete_comment(user)
    if authored_by?(user)
      destroy
      'Comment deleted successfully!'
    else
      "Sorry, you can't delete this comment. You are not the author!"
    end
  end

  private

  def authored_by?(user)
    author == user
  end
end
