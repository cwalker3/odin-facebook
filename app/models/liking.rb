class Liking < ApplicationRecord
  belongs_to :user
  belongs_to :post, foreign_key: :liked_id
  belongs_to :comment, foreign_key: :liked_id
end
