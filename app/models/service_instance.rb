class ServiceInstance < ApplicationRecord
  belongs_to :service_template
  belongs_to :mitra

  enum :status, { draft: 0, published: 1, unpublished: 2, archived: 3 }

  validates :name, :service_template_id, :mitra_id, presence: true
  validates :service_area, presence: true, if: :published?
end
