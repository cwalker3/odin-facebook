class Post < ApplicationRecord
  belongs_to :user
  has_many :likings, -> { where(kind: 'post') }, foreign_key: :liked_id, dependent: :destroy
  has_many :likes, through: :likings, source: :user
  has_many :comments, dependent: :destroy

  def self.posts_from(ids)
    Post.all.includes(:likes, :comments, :user).where(user_id: ids).order(updated_at: :desc)
  end
end
