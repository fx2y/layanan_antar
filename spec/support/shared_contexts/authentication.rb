RSpec.shared_context 'with authenticated master admin' do
  let(:current_user) { create(:user, :master_admin) }
  before { sign_in current_user }
end

RSpec.shared_context 'with authenticated mitra admin' do
  let(:current_user) { create(:user, :mitra_admin) }
  let(:administered_mitra) { create(:mitra) }
  before do
    allow(current_user).to receive(:mitra_admin_for?).and_return(false)
    allow(current_user).to receive(:mitra_admin_for?).with(administered_mitra).and_return(true)
    allow(current_user).to receive(:administered_mitras).and_return([ administered_mitra ])
    sign_in current_user
  end
end
