class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :following, class_name: User.name
end
