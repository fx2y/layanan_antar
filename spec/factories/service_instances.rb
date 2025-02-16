FactoryBot.define do
  factory :service_instance do
    name { Faker::Company.catch_phrase }
    description { Faker::Company.bs }
    pricing_details { { base_price: 12000, per_km: 2500 } }
    service_area { { center: { lat: -6.2088, lng: 106.8456 }, radius: 5000 } }
    status { :draft }
    association :service_template
    association :mitra
  end
end
