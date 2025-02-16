require 'rails_helper'

RSpec.describe Mitra, type: :model do
  describe 'associations' do
    it { should have_many(:service_instances).dependent(:destroy) }
    it { should have_many(:mitra_drivers).dependent(:destroy) }
    it { should have_many(:drivers).through(:mitra_drivers) }
  end

  describe 'validations' do
    it { should validate_presence_of(:business_name) }
    it { should validate_presence_of(:contact_person_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(pending: 0, active: 1, inactive: 2, suspended: 3) }
  end
end
