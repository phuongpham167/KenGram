class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  attr_accessor :remember_token
  before_save :downcase_email

  validates :name, presence: true, length: { maximum: Settings.user.name.max_lenght}
  VALID_EMAIL_REGAX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: Settings.user.email.max_lenght}, format: { with: VALID_EMAIL_REGAX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: Settings.user.password.min_lenght }

  def User.digest string
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
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

  def feed
    Post.where("user_id = ?", id)
  end

  def follow other_user

  end

  def unfollow other_user

  end

  def  following? other_user

  end
  private
    def downcase_email
      self.email = email.downcase
    end
end
