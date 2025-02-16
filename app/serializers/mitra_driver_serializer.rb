class MitraDriverSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :updated_at

  belongs_to :mitra
  belongs_to :driver
end
