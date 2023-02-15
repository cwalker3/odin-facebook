class Post < ApplicationRecord
  belongs_to :user
  has_many :likings, as: :likeable, dependent: :destroy
  has_many :likes, through: :likings, source: :user
  has_many :comments, dependent: :destroy

  def self.posts_from(ids)
    Post.all.includes(:likes, :user, { comments: [:likes, :user] }).where(user_id: ids).order(updated_at: :desc)
  end
end
