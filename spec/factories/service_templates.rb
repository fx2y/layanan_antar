FactoryBot.define do
  factory :service_template do
    name { Faker::Company.catch_phrase }
    description { Faker::Company.bs }
    pricing_schema { { base_price: 10000, per_km: 2000 } }
    service_area_schema { { radius: 5000, unit: 'meters' } }
    status { :draft }
  end
end
