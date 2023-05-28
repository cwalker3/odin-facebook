class Profile < ApplicationRecord
  include Gravtastic
  has_gravatar

  has_one_attached :avatar do |attachable|
    attachable.variant :small, resize_to_fill: [50, 50]
    attachable.variant :large, resize_to_fit: [300, 300]
  end

  belongs_to :user

  validate :is_13_or_older

  validates_presence_of :first_name, :last_name, :birth_date

  def name
    first_name + ' ' + last_name
  end

  # for Gravatar
  def email
    user.email
  end

  def small_avatar
    if avatar.attached?
      avatar.variant(:small)
    else
      gravatar_url(size: 50)
    end
  end

  def large_avatar
    if avatar.attached?
      avatar.variant(:large)
    else
      gravatar_url(size: 300)
    end
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
