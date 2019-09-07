# frozen_string_literal: true

class User < ApplicationRecord
  self.primary_key = 'id'

  before_create { email.strip.downcase! }
  before_create :capitalize_names
  before_create { build_gravatar_image_url }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true, length: { within: 2..50 }
  validates :last_name, presence: true, length: { within: 2..50 }
  validates :email, presence: true, format: Devise.email_regexp
  validates :sex, presence: true, inclusion: { in: %w[Male Female Custom] }
  validates :dob, presence: true

  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'liker_id', dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy

  def fullname
    "#{first_name} #{last_name}"
  end

  def create_post(post_params)
    posts.create post_params
  end

  def like(resource)
    return if self.likes.create(likeable: resource)

    'Sorry, you are not authorized to like on this resource.'
  end

  def dislike(resource)
    like = self.likes.where(likeable: resource, liker: self).first
    return if like && like.destroy

    'Sorry, but you never liked this post!'
  end

  def friends_with(other_user)
    # to be done in friendship milestone
    other_user.is_a? User
  end

  private

  def capitalize_names
    first_name.capitalize!
    last_name.capitalize!
  end

  def build_gravatar_image_url
    self.image = "https://gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}"
  end
end
