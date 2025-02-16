class Driver < ApplicationRecord
  has_many :mitra_drivers
  has_many :mitras, through: :mitra_drivers
end 