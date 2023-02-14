class Post < ApplicationRecord
  belongs_to :user
  has_many :likings, dependent: :destroy
  has_many :likes, through: :likings, source: :user
  has_many :comments, dependent: :destroy
end
