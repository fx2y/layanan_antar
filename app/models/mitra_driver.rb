class MitraDriver < ApplicationRecord
  belongs_to :driver
  belongs_to :mitra

  validates :driver_id, :mitra_id, presence: true
  validates :driver_id, uniqueness: { scope: :mitra_id }
end
