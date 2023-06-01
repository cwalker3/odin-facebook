class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :liked_by_user, through: :likes, source: :user
  has_many :comments, dependent: :destroy

  validate :image_or_body_present

  has_one_attached :image do |attachable|
    attachable.variant :resized, resize_to_limit: [600, 600]
  end

  validates :image, content_type: {
    in: %w[image/png image/jpg image/jpeg image/gif], 
    message: 'Must be a valid image format' 
  }

  def self.posts_from(ids)
    Post.all.includes(:likes, :liked_by_user, { image_attachment: :blob }, { user: { profile: { avatar_attachment: :blob }}}, { comments: [:user, :likes, :liked_by_user] } ).where(user_id: ids).order(updated_at: :desc)
  end

  def posted_at
    created_at.strftime('%b %d, %Y %I:%M%p %Z')
  end

  private

  def image_or_body_present
    if body.blank? && !image.attached?
      errors.add(:base, "Post must have an image or text")
    end
  end
end
