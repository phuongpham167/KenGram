class Post < ApplicationRecord
  belongs_to :user
  belongs_to :album
  scope :recent, ->{order(created_at: :desc)}
  has_many :post_attachments
  has_many :passive_likes, class_name:  Like.name,
    foreign_key: "post_id", dependent: :destroy
  has_many :post_likes, through: :passive_likes, source: :user
  has_many :passive_bookmarks, class_name:  Bookmark.name,
    foreign_key: "post_id", dependent: :destroy
  has_many :post_bookmarks, through: :passive_bookmarks, source: :user

  validates :user_id, presence: true

  scope :by_user, (lambda do |user_id, following_ids|
    Post.where("user_id IN (:following_ids) OR user_id = :user_id",
      following_ids: following_ids, user_id: user_id)
  end)
  scope :search, (lambda do |keyword|
    unless keyword.blank?
      sql_statement = "posts.caption LIKE ? OR posts.tag LIKE ? "
      where(sql_statement, "%#{keyword}%", keyword.to_s)
    end
  end)
end
