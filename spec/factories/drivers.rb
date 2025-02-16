FactoryBot.define do
  factory :driver do
    name { Faker::Name.name }
    phone { Faker::PhoneNumber.cell_phone }
    email { Faker::Internet.email }
    status { :active }
  end
end
