class MitraSerializer < ActiveModel::Serializer
  attributes :id, :business_name, :business_address, :contact_person_name,
             :contact_person_phone, :email, :status, :created_at, :updated_at

  has_many :service_instances
  has_many :mitra_drivers
end
