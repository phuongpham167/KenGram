class Album < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  validates :user_id, presence: true
  validates :name, presence: true, length: {maximum: Settings.album.name.max_length}
  validates :caption, presence: true, length: {maximum: Settings.album.caption.max_length}
end
