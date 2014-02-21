
ActiveRecord::Base.transaction do

  3.times do
    User.create!(
      user_name: Faker::Internet.user_name,
      password: 'foobar'
    )
  end
  owner_ids = User.all.pluck(:id)

  10.times do
    age = Integer(Faker::Number.digit)
    Cat.create!(
      name: Faker::Name.name,
      age: age,
      color: Cat::ALLOWED_COLORS.sample,
      sex: Cat::SEXES.keys.sample,
      birth_date: age.years.ago,
      user_id: owner_ids.sample
    )
  end

  cat1 = Cat.find(1)
  cat1.rental_requests.create!(
    start_date: Time.now,
    end_date: 1.day.from_now
  )
  cat1.rental_requests.create!(
    start_date: 1.day.from_now,
    end_date: 3.days.from_now
  )
  cat1.rental_requests.create!(
    start_date: 2.day.from_now,
    end_date: 4.days.from_now
  )
  cat1.rental_requests.create!(
    start_date: 6.day.from_now,
    end_date: 8.days.from_now
  )
  cat1.rental_requests.create!(
    start_date: 5.day.from_now,
    end_date: 7.days.from_now
  )
  Cat.find(2).rental_requests.create!(
    start_date: 6.day.from_now,
    end_date: 8.days.from_now
  )

end
