FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.unique.username(specifier: 10..20) }
    password { Faker::Internet.password(min_length: 8) }
    full_name { Faker::Name.name }
    gender { Faker::Gender.binary_type } # Randomly generates 'male' or 'female'
    dob { Faker::Date.birthday(min_age: 18, max_age: 65) }
    country { Faker::Address.country }
    city { Faker::Address.city }
  end
end
