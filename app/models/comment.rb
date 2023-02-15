class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likings, as: :likeable, dependent: :destroy
  has_many :likes, through: :likings, source: :user
end
