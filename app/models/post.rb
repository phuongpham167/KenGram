class Post < ApplicationRecord
  belongs_to :user
  scope :recent, -> { order(created_at: :desc) }
  has_many :post_attachments

  validates :user_id, presence: true

end
