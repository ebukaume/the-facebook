class Post < ApplicationRecord
  self.primary_key = 'id'

  belongs_to :author, class_name: 'User'
end
