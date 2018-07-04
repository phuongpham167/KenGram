class Post < ApplicationRecord
  belongs_to :user
  belongs_to :album
  default_scope -> { order(created_at: :desc) }
  has_many :post_attachments

  validates :user_id, presence: true
end
