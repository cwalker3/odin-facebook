class Post < ApplicationRecord
  belongs_to :user
  has_many :likings
  has_many :likes, through: :likings, source: :user
end
