FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password123' }
    password_confirmation { 'password123' }
    role { 'customer' }
    profile_data { { name: Faker::Name.name } }

    trait :master_admin do
      role { 'master_admin' }
    end

    trait :mitra_admin do
      role { 'mitra_admin' }
    end

    trait :driver do
      role { 'driver' }
    end
  end
end
