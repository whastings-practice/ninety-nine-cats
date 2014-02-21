# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Session < ActiveRecord::Base
  validates :token, :user_id, presence: true

  after_initialize :check_token

  belongs_to(
    :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"
  )

  SESSION_TOKEN_LENGTH = 16

  def self.find_user_by_token(token)
    user_id = self.where(token: token).pluck(:user_id).first
    user_id ? User.find_by_id(user_id) : nil
  end

  def self.new_token
    SecureRandom::urlsafe_base64(SESSION_TOKEN_LENGTH)
  end

  private

  def check_token
    self.token ||= self.class.new_token
  end
end
