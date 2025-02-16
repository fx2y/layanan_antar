class Mitra < ApplicationRecord
  has_many :service_instances, dependent: :destroy
  has_many :mitra_drivers, dependent: :destroy
  has_many :drivers, through: :mitra_drivers

  enum :status, { pending: 0, active: 1, inactive: 2, suspended: 3 }

  validates :business_name, :contact_person_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
end
