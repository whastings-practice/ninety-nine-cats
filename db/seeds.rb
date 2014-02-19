
ActiveRecord::Base.transaction do

  10.times do
    age = Integer(Faker::Number.digit)
    Cat.create!(
      name: Faker::Name.name,
      age: age,
      color: Cat::ALLOWED_COLORS.sample,
      sex: Cat::SEXES.keys.sample,
      birth_date: age.years.ago
    )
  end

end
