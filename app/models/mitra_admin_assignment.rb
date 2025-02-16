class MitraAdminAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :mitra

  validates :user, presence: true
  validates :mitra, presence: true
  validates :user_id, uniqueness: { scope: :mitra_id }
  validate :user_must_be_mitra_admin

  private

  def user_must_be_mitra_admin
    errors.add(:user, "must be a mitra admin") unless user&.mitra_admin?
  end
end
