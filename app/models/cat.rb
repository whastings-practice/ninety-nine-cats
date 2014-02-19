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
#

class Cat < ActiveRecord::Base
  ALLOWED_COLORS = %w(black white gray orange brown)
  SEXES = { "M" => "male", "F" => "female" }

  validates :name, presence: true
  validates :age, numericality: true
  validates :color, inclusion: { in: ALLOWED_COLORS }
  validates :sex, inclusion: { in: SEXES.keys }
end
