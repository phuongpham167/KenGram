class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :active_likes, class_name:  Like.name,
    foreign_key: "user_id", dependent: :destroy
  has_many :user_like, through: :active_likes, source: :post
  has_many :active_bookmarks, class_name:  Bookmark.name,
    foreign_key: "user_id", dependent: :destroy
  has_many :user_bookmarks, through: :active_bookmarks, source: :post
  has_many :post_comments, dependent: :destroy

  attr_accessor :remember_token
  before_save :downcase_email

  validates :name, presence: true,
    length: {maximum: Settings.user.name.max_lenght}
  VALID_EMAIL_REGAX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
    length: {maximum: Settings.user.email.max_lenght},
    format: {with: VALID_EMAIL_REGAX},
    uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, length: {minimum: Settings.user.password.min_lenght}

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :following_id, dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :followings, through: :active_relationships, source: :following

  def self.digest string
    min_cost = BCrypt::Engine::MIN_COST
    engine_cost = BCrypt::Engine.cost
    cost = ActiveModel::SecurePassword.min_cost ? min_cost : engine_cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attributes remember_digest: User.digest(remember_token)
  end

  def authenticated? remember_token
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def like post_id
    user_like << post_id
  end

  def unlike post_id
    user_like.delete post_id
  end

  def like? post_id
    user_like.include? post_id
  end

  def bookmark post_id
    user_bookmarks << post_id
  end

  def unbookmark post_id
    user_bookmarks.delete post_id
  end

  def bookmark? post_id
    user_bookmarks.include? post_id
  end

  def follow other_user
    followings << other_user
  end

  def unfollow other_user
    followings.delete other_user
  end

  def following? other_user
    followings.include? other_user
  end

  private
  def downcase_email
    email.downcase!
  end
end
