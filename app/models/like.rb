# frozen_string_literal: true

class Like < ApplicationRecord
  self.primary_key = 'id'

  belongs_to :likeable, polymorphic: true
  belongs_to :liker, class_name: 'User'

  default_scope -> { includes(:liker) }
end
