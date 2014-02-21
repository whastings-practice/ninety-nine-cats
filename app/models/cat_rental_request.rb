# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string(10)       not null
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer
#

class CatRentalRequest < ActiveRecord::Base
  STATUSES = %w(PENDING APPROVED DENIED)

  validates :cat_id, :start_date, :end_date, :status, :user_id, presence: true
  validates :status, inclusion: { in: STATUSES }
  validate :overlapping_approved_requests

  belongs_to(
    :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "Cat"
  )

  belongs_to(
    :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"
  )

  before_validation :check_status

  def self.requests_for_cat(cat_id)
    where(cat_id: cat_id).order(:start_date)
  end

  def deny!
    self.status = 'DENIED'
    self.save!
  end

  def approve!
    self.status = 'APPROVED'
    self.class.transaction do
      self.save!
      overlapping_pending_requests.update_all(status: 'DENIED')
    end
  end

  def pending?
    self.status == 'PENDING'
  end

  protected

  def check_status
    self.status ||= STATUSES.first
  end

  def overlapping_approved_requests
    return unless self.status == 'APPROVED'
    if overlapping_requests.where(status: 'APPROVED').exists?
      errors[:status] << "cannot be approved while an overlapping request exists"
    end
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  private

  def overlapping_requests
    where_string = <<-SQL
      ((start_date BETWEEN :start_date AND :end_date)
      OR (end_date BETWEEN :start_date AND :end_date))
      AND id <> :id
      AND cat_id = :cat_id
    SQL
    self.class.where(
      where_string,
      start_date: self.start_date,
      end_date: self.end_date,
      id: self.id,
      cat_id: self.cat_id
    )
  end
end
