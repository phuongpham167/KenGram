class Post < ApplicationRecord
  belongs_to :user
  belongs_to :album
  scope :recent, ->{order(created_at: :desc)}
  has_many :post_attachments

  validates :user_id, presence: true

  scope :by_user, (lambda do |user_id|
    where user_id: user_id
  end)
  
  scope :search, (lambda do |keyword|
    unless keyword.blank?
      sql_statement = "posts.caption LIKE ? OR posts.tag LIKE ? "
      where(sql_statement, "%#{keyword}%", keyword.to_s)
    end
  end)
end
