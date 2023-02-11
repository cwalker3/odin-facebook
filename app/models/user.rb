class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  validates :first_name, :last_name, :birth_date, presence: true
  validate :is_13_or_older

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
