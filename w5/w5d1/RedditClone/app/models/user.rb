class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password
  after_initialize :ensure_token

  has_many :subs
  has_many :posts
  has_many :sub_posts

  def self.find_by_creds(username, password)
    @user = User.find_by(username: username)
    return nil unless @user && @user.valid_password?(password)
    @user
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def valid_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end

  def generate_token
    SecureRandom.urlsafe_base64
  end

  def update_token!
    session_token = SecureRandom.urlsafe_base64
    self.save
  end

  def ensure_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
end
