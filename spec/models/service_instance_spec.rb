require 'rails_helper'

RSpec.describe ServiceInstance, type: :model do
  describe 'associations' do
    it { should belong_to(:service_template) }
    it { should belong_to(:mitra) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:service_template_id) }
    it { should validate_presence_of(:mitra_id) }

    context 'when published' do
      before { allow(subject).to receive(:published?).and_return(true) }
      it { should validate_presence_of(:service_area) }
    end

    context 'when not published' do
      before { allow(subject).to receive(:published?).and_return(false) }
      it { should_not validate_presence_of(:service_area) }
    end
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(draft: 0, published: 1, unpublished: 2, archived: 3) }
  end
end
