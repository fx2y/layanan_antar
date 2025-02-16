require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:profile_data) }
  end

  describe 'enums' do
    it {
      should define_enum_for(:role).with_values(
        customer: 'customer',
        mitra_admin: 'mitra_admin',
        driver: 'driver',
        master_admin: 'master_admin'
      ).backed_by_column_of_type(:string)
    }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user)).to be_valid
    end

    it 'has valid role-specific factories' do
      expect(build(:user, :mitra_admin)).to be_valid
      expect(build(:user, :master_admin)).to be_valid
      expect(build(:user, :driver)).to be_valid
    end
  end

  describe '#mitra_admin_for?' do
    let(:user) { create(:user, :mitra_admin) }
    let(:mitra) { create(:mitra) }

    it 'returns false for non-mitra-admin users' do
      user.update!(role: :customer)
      expect(user.mitra_admin_for?(mitra)).to be false
    end

    it 'returns false for unauthorized mitras' do
      expect(user.mitra_admin_for?(mitra)).to be false
    end
  end

  describe '#administered_mitras' do
    let(:user) { create(:user) }

    context 'when master admin' do
      before { user.update!(role: :master_admin) }

      it 'returns all mitras' do
        mitras = create_list(:mitra, 3)
        expect(user.administered_mitras).to match_array(mitras)
      end
    end

    context 'when mitra admin' do
      before { user.update!(role: :mitra_admin) }

      it 'returns no mitras by default' do
        create_list(:mitra, 3)
        expect(user.administered_mitras).to be_empty
      end
    end

    context 'when regular user' do
      it 'returns no mitras' do
        create_list(:mitra, 3)
        expect(user.administered_mitras).to be_empty
      end
    end
  end
end
