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
  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true
  validates :user_name, length: { minimum: 3, maximum: 50 }
  validates :password, length: { minimum: 6, allow_nil: true }

  has_many(
    :cats,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Cat"
  )

  has_many(
    :sessions,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Session"
  )

  def self.find_by_credentials(user_name, password)
    user = self.find_by_user_name(user_name)
    (user && user.is_password?(password)) ? user : nil
  end

  def password=(password_string)
    @password = password_string
    self.password_digest = BCrypt::Password.create(password_string)
  end

  def is_password?(password_string)
    BCrypt::Password.new(self.password_digest).is_password?(password_string)
  end

  def owns_cat?(cat_id)
    self.cats.where(id: cat_id).exists?
  end

  private

  attr_reader :password
end
