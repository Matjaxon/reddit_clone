class User < ActiveRecord::Base
  validates :username, :session_token, :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :username, uniqueness: true

  attr_reader :password

  after_initialize :ensure_session_token

  has_many :subs, foreign_key: :moderator_id
  has_many :posts, foreign_key: :author_id  

  def self.find_by_credentials(username,password)
    @user = User.find_by(username: username)
    return nil if @user.nil?
    @user.is_password?(password) ? @user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(32)
    self.save
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(32)
  end

end
