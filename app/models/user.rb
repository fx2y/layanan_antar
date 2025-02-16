class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :api

  enum :role, {
    customer: "customer",
    mitra_admin: "mitra_admin",
    driver: "driver",
    master_admin: "master_admin"
  }, default: "customer"

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                   format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: roles.keys }
  validates :profile_data, presence: true

  has_many :mitra_admin_assignments
  has_many :administered_mitras, through: :mitra_admin_assignments, source: :mitra

  def mitra_admin_for?(mitra)
    mitra_admin? && administered_mitras.include?(mitra)
  end

  def administered_mitras
    return Mitra.all if master_admin?
    return Mitra.none unless mitra_admin?
    super
  end
end
