class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :first_name, :last_name, :birth_date, presence: true
  validate :is_13_or_older

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likings, dependent: :destroy
  has_many :liked_posts, through: :likings, source: :post
  has_many :friendships, ->(user) { unscope(where: :user_id).where("friend1_id = ? OR friend2_id = ?", user.id, user.id) }, dependent: :destroy
  has_many :friend1s, ->(user) { where.not("friendships.friend1_id = ?", user.id) }, through: :friendships
  has_many :friend2s, ->(user) { where.not("friendships.friend2_id = ?", user.id) }, through: :friendships
  has_many :friend_requests, ->(user) { unscope(where: :user_id).where("requestor_id = ? OR requestee_id = ?", user.id, user.id) }, dependent: :destroy
  has_many :requestees, through: :friend_requests
  has_many :requestors, through: :friend_requests

  def friends
    friend1s.to_a + (friend2s.to_a)
  end

  def name
    first_name + ' ' + last_name
  end

  def pending_request?(user)
    requestees.include?(user)
  end

  def friends_with?(user)
    friends.include?(user)
  end

  def self.user_and_friends_ids(user)
    user.friends.pluck(:id) << user.id
  end

  private

  def is_13_or_older
    if user_age < 13
      errors.add(:base, 'You must be at least 13 years old to sign up')
    end
  end

  def user_age
    age = Date.today.year - birth_date.year
    age -= 1 if Date.today < birth_date + age.years
    age
  end
end
