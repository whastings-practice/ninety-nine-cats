# == Schema Information
#
# Table name: cats
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  age        :integer
#  birth_date :date
#  color      :string(20)
#  sex        :string(1)
#  created_at :datetime
#  updated_at :datetime
#  user_id    :integer          default(0), not null
#

class Cat < ActiveRecord::Base
  ALLOWED_COLORS = %w(black white gray orange brown)
  SEXES = { "M" => "male", "F" => "female" }

  validates :name, :user_id, presence: true
  validates :age, numericality: true
  validates :color, inclusion: { in: ALLOWED_COLORS }
  validates :sex, inclusion: { in: SEXES.keys }

  has_many(
    :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: "CatRentalRequest",
    dependent: :destroy
  )

  belongs_to(
    :owner,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"
  )
end
