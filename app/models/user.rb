# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  user_name       :string(50)       not null
#  password_digest :string(60)       not null
#  created_at      :datetime
#  updated_at      :datetime
#  email           :string(255)
#

class User < ActiveRecord::Base
  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true
  validates :user_name, length: { minimum: 3, maximum: 50 }
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :email, presence: true

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

  has_many(
    :rental_requests,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "CatRentalRequest"
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

  def send_reminder_email
    UserMailer.reminder_email(self).deliver
  end
  handle_asynchronously :send_reminder_email, run_at: -> { 1.week.from_now }

  private

  attr_reader :password
end
