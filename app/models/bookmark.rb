class Bookmark < ApplicationRecord
  belongs_to :user, class_name: User.name
  belongs_to :post, class_name: Post.name
end
