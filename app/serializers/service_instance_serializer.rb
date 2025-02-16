class ServiceInstanceSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :pricing_details, :service_area,
             :status, :created_at, :updated_at

  belongs_to :mitra
  belongs_to :service_template
end
