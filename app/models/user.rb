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
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  def fullname
    "#{first_name} #{last_name}"
  end

  def create_post(post_params)
    posts.create post_params
  end

  def friends_with?(other_user)
    Friendship.confirmed_friends(self).any? other_user
  end

  def sent_request_to?(other_user)
    Friendship.pending_friends(self).any? other_user
  end

  def received_request_from?(other_user)
    Friendship.pending_requests(self).any? other_user
  end

  def request_friendship(user_id)
    other_user = User.find_by(id: user_id)
    return 'The user you wish to send request to does not exist!' if other_user.nil?
    return "Sorry, you can't send friend request to yourself" if self == other_user
    return "You are already friends with #{other_user.fullname}!" if friends_with? other_user
    return "You already sent friend request to #{other_user.fullname}" if sent_request_to? other_user
    return "You seem to already have a pending request from #{other_user.fullname}" if received_request_from? other_user

    friendships.create(friend: other_user)
    "Friend request successfully sent to #{other_user.fullname}"
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
