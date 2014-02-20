# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(50)       not null
#  password_digest :string(60)       not null
#  session_token   :string(100)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :user_name, :password_digest, :session_token, presence: true
  validates :user_name, :session_token, uniqueness: true
  validates :user_name, length: { minimum: 3, maximum: 50 }
  validates :password, length: { minimum: 6, allow_nil: true }

  before_validation :check_session_token

  SESSION_TOKEN_LENGTH = 16

  def self.new_session_token
    SecureRandom::urlsafe_base64(SESSION_TOKEN_LENGTH)
  end

  def self.find_by_credentials(user_name, password)
    user = self.find_by_user_name(user_name)
    (user && user.is_password?(password)) ? user : nil
  end

  def reset_session_token!
    self.session_token = self.class.new_session_token
    self.save!
    self.session_token
  end

  def password=(password_string)
    @password = password_string
    self.password_digest = BCrypt::Password.create(password_string)
  end

  def is_password?(password_string)
    BCrypt::Password.new(self.password_digest).is_password?(password_string)
  end

  private

  attr_reader :password

  def check_session_token
    self.session_token ||= self.class.new_session_token
  end
end
