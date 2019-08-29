class Post < ApplicationRecord
  self.primary_key = 'id'
  validates :content, presence: true, length: {minimum: 2}

  belongs_to :author, class_name: 'User'
end
