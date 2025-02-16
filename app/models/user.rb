class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :api

  enum :role, {
    customer: 'customer',
    mitra_admin: 'mitra_admin',
    driver: 'driver',
    master_admin: 'master_admin'
  }, default: 'customer'

  validates :email, presence: true, uniqueness: true,
                   format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true, inclusion: { in: roles.keys }
  validates :profile_data, presence: true
end
