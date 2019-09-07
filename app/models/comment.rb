# frozen_string_literal: true

class Comment < ApplicationRecord
  self.primary_key = 'id'
  validates :content, presence: true

  belongs_to :author, class_name: 'User'
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  default_scope -> { includes(:author, :likes) }
end
