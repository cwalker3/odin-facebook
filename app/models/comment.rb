class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likings, -> { where(kind: 'comment') }, foreign_key: :liked_id, dependent: :destroy
  has_many :likes, through: :likings, source: :user
end
