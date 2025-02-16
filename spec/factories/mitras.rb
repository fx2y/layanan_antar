FactoryBot.define do
  factory :mitra do
    business_name { Faker::Company.name }
    business_address { Faker::Address.full_address }
    contact_person_name { Faker::Name.name }
    contact_person_phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    status { :pending }
  end
end
