class Post < ApplicationRecord
  self.primary_key = 'id'
  validates :content, presence: true, length: {minimum: 2}, 
            uniqueness: { scope: :author, message: "should be unique per user!" }

  belongs_to :author, class_name: 'User'

  scope :visible_to_user,  -> {  }
  scope :authored_by,  ->(user) { where(author: user) }

  default_scope -> { order('updated_at DESC').includes(:author) }

  def delete_post(user)
    if authored_by?(user)
      self.destroy
      "Post deleted successfully!"
    else
      "Sorry, you can't delete this post. You are not the author!"
    end
  end

  def update_post(user, post_params)
    if authored_by?(user)
      if self.update_attributes(post_params)
        "Post successfuly edited!"
      else
        "Oops! Please make sure the content is at least 2 character long!" 
      end
    else
      "Sorry, but you are not the author of this post!"
    end
  end

  def can_edit?(user)
    authored_by?(user)
  end

  private

  def authored_by?(user)
    author == user
  end
end
