class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, length: {maximum: Settings.post_comment.max_content}
end
