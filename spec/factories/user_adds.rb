FactoryBot.define do
    factory :user_add do
      association :user  
      city { Faker::Address.city }
      registered_in { "Registered" }
      exterior_color { Faker::Vehicle.color }
      mileage { Faker::Number.number(digits: 5) }
      price { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
      add_description { Faker::Lorem.paragraph }
      mobile_number { Faker::PhoneNumber.phone_number }
      
    end
  end