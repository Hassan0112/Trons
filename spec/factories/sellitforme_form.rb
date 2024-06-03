FactoryBot.define do
  factory :sellitforme_form do
    association :user
    model_year { Faker::Vehicle.year }
    car_info { Faker::Vehicle.make_and_model }
    registered_in { %w[Punjab Sindh].sample }
    assembly { %w[Local Imported].sample }
    location { Faker::Address.city }
    address { Faker::Address.full_address }
    inspection_slot { Faker::Time.forward(days: 23, period: :morning) }
    full_name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone_in_e164 }
  end
end  