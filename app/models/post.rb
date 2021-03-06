# frozen_string_literal: true

class Post < ApplicationRecord
  self.primary_key = 'id'
  validates :content, presence: true, length: { minimum: 2 },
                      uniqueness: { scope: :author, message: 'should be unique per user!' }

  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  scope :authored_by, ->(user) { where(author: user).order('updated_at DESC') }

  default_scope -> { includes(:author, :comments, :likes) }

  def self.visible_to_user(user)
    find_by_sql(["SELECT * FROM posts
      WHERE author_id = ?
      OR author_id IN (
        SELECT friend_id FROM friendships
          WHERE user_id = ?
          AND confirmed = true)
      ORDER BY posts.updated_at DESC", user.id, user.id])
  end

  def delete_post(user)
    return "Sorry, you can't delete this post. You are not the author!" unless authored_by?(user)

    destroy
    'Post deleted successfully!'
  end

  def update_post(user, post_params)
    return 'Sorry, but you are not the author of this post!' unless authored_by? user

    if update_attributes(post_params)
      'Post successfuly edited!'
    else
      'Oops! Please make sure the content is at least 2 character long!'
    end
  end

  def create_comment(user, comment_params)
    return 'Sorry, you are not authorized to comment on this post.' unless can_comment? user

    comment = comments.build(comment_params)
    if comment.save
      'Comment saved sucessfully!'
    else
      'Comment not saved; Did you try to submit a blank comment?'
    end
  end

  def can_comment?(user)
    authored_by?(user) || user.friends_with?(author)
  end

  def can_edit?(user)
    authored_by?(user)
  end

  private

  def authored_by?(user)
    author == user
  end
end
