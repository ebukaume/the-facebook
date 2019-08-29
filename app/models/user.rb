class User < ApplicationRecord
  self.primary_key = 'id'
  before_create { self.image = 'todo_gravatar_later' }
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :first_name, presence: true, length: {within: 2..50}
  validates :last_name, presence: true, length: {within: 2..50}
  validates :email, presence: true, format: Devise::email_regexp
  validates :sex, presence: true, inclusion: { in: %w(Male Female Custom) }
  validates :dob, presence: true

  has_many :posts, foreign_key: 'author_id'
end
