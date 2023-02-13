class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :first_name, :last_name, :birth_date, presence: true
  validate :is_13_or_older

  has_many :posts
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :friend_requests
  has_many :requestors, through: :friend_requests

  def name
    first_name + ' ' + last_name
  end

  def has_request_from?(user)
    requestors.include?(user)
  end

  def friends_with?(user)
    friends.include?(user)
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
