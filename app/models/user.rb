class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likings, source: :post
  has_many :liked_comments, through: :likings, source: :comment
  has_many :friendships, ->(user) { unscope(where: :user_id).where('friend1_id = ? OR friend2_id = ?', user.id, user.id) }, dependent: :destroy
  has_many :friend1s, ->(user) { where.not('friend1_id = ?', user.id) }, through: :friendships
  has_many :friend2s, ->(user) { where.not('friend2_id = ?', user.id) }, through: :friendships
  has_many :friend_requests, ->(user) { unscope(where: :user_id).where('requestee_id = ? OR requestor_id = ?', user.id, user.id) }, dependent: :destroy
  has_many :requestees, ->(user) { where.not('requestee_id = ?', user.id) }, through: :friend_requests
  has_many :requestors, ->(user) { where.not('requestor_id = ?', user.id) }, through: :friend_requests
  has_one :profile, dependent: :destroy

  accepts_nested_attributes_for :profile

  def friends
    friend1s.to_a + friend2s.to_a
  end

  def pending_request?(user)
    requestees.include?(user)
  end

  def friends_with?(user)
    friends.include?(user)
  end

  def user_and_friends_ids
    friends.pluck(:id) << id
  end

  def after_confirmation
    UserMailer.with(user: self).welcome_email.deliver_later
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.profile.create do |profile|
        profile.first_name = auth.first_name
        profile.last_name = auth.last_name
        profile.gender = auth.extra.raw_info.gender
      end
      user.skip_confirmation!
    end
  end
end
