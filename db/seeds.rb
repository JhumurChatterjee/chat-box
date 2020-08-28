15.times do
  password = Faker::Internet.password(min_length: 8, max_length: 20)

  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password
  )
end
