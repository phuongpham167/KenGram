class Post < ApplicationRecord
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  has_many :post_attachments
  accepts_nested_attributes_for :post_attachments

  validates :user_id, presence: true
end
