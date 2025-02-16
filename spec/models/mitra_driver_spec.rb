require 'rails_helper'

RSpec.describe MitraDriver, type: :model do
  describe 'associations' do
    it { should belong_to(:driver) }
    it { should belong_to(:mitra) }
  end

  describe 'validations' do
    subject { build(:mitra_driver) }
    it { should validate_presence_of(:driver_id) }
    it { should validate_presence_of(:mitra_id) }
    it { should validate_uniqueness_of(:driver_id).scoped_to(:mitra_id) }
  end
end
