class ServiceTemplate < ApplicationRecord
  has_many :service_instances, dependent: :restrict_with_error

  enum :status, { draft: 0, published: 1, archived: 2 }

  validates :name, presence: true
  validates :pricing_schema, :service_area_schema, presence: true, if: :published?
end
