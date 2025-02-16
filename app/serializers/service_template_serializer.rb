class ServiceTemplateSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :pricing_schema,
             :service_area_schema, :status, :created_at, :updated_at

  has_many :service_instances
end
