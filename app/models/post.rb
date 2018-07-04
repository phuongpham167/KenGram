class Post < ApplicationRecord
  belongs_to :user
  scope :recent, -> { order(created_at: :desc) }
  has_many :post_attachments

  validates :user_id, presence: true

  Post.transaction do
    Post.create
    PostAttachment.transaction do
      PostAttachment.create
    end
  end
end
