class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liked_by_user, through: :likes, source: :user

  validates :body, presence: true
end
