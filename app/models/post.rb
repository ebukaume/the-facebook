class Post < ApplicationRecord
  self.primary_key = 'id'
  validates :content, presence: true, length: {minimum: 2}, 
            uniqueness: { scope: :author, message: "should be unique per user!" }

  belongs_to :author, class_name: 'User'

  scope :visible_to_user,  -> {  }
  scope :authored_by,  ->(user) { where(author: user) }

  default_scope -> { order('updated_at DESC').includes(:author) }
end
