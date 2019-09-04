class Post < ApplicationRecord
  self.primary_key = 'id'
  validates :content, presence: true, length: {minimum: 2}, 
            uniqueness: { scope: :author, message: "should be unique per user!" }

  belongs_to :author, class_name: 'User'

  scope :recent,  -> { order('updated_at DESC') }
end
