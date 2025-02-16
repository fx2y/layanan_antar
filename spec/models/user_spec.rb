require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:profile_data) }
  end

  describe 'enums' do
    it { should define_enum_for(:role).with_values(
      customer: 'customer',
      mitra_admin: 'mitra_admin',
      driver: 'driver',
      master_admin: 'master_admin'
    ).backed_by_column_of_type(:string) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it 'has valid role-specific factories' do
      expect(build(:user, :mitra_admin)).to be_valid
      expect(build(:user, :driver)).to be_valid
      expect(build(:user, :master_admin)).to be_valid
    end
  end
end
