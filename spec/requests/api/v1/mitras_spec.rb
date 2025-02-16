require 'rails_helper'

RSpec.describe 'Api::V1::Mitras', type: :request do
  let(:valid_attributes) do
    {
      business_name: 'Test Business',
      business_address: 'Test Address',
      contact_person_name: 'John Doe',
      contact_person_phone: '+1234567890',
      email: 'test@example.com'
    }
  end

  describe 'GET /api/v1/mitras' do
    include_context 'with authenticated master admin'
    let!(:mitras) { create_list(:mitra, 3) }

    it 'returns all mitras' do
      get '/api/v1/mitras'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /api/v1/mitras/:id' do
    context 'as master admin' do
      include_context 'with authenticated master admin'
      let(:mitra) { create(:mitra) }

      it 'returns the mitra' do
        get "/api/v1/mitras/#{mitra.id}"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(mitra.id)
      end
    end

    context 'as mitra admin' do
      include_context 'with authenticated mitra admin'

      it 'returns the mitra if authorized' do
        get "/api/v1/mitras/#{administered_mitra.id}"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(administered_mitra.id)
      end

      it 'returns forbidden for unauthorized mitra' do
        other_mitra = create(:mitra)
        get "/api/v1/mitras/#{other_mitra.id}"
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST /api/v1/mitras' do
    it 'creates a new mitra' do
      expect {
        post '/api/v1/mitras', params: { mitra: valid_attributes }
      }.to change(Mitra, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'returns validation errors for invalid data' do
      post '/api/v1/mitras', params: { mitra: valid_attributes.merge(email: '') }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT /api/v1/mitras/:id' do
    context 'as master admin' do
      include_context 'with authenticated master admin'
      let(:mitra) { create(:mitra) }

      it 'updates the mitra' do
        put "/api/v1/mitras/#{mitra.id}", params: { mitra: { business_name: 'Updated Name' } }
        expect(response).to have_http_status(:ok)
        expect(mitra.reload.business_name).to eq('Updated Name')
      end
    end
  end

  describe 'DELETE /api/v1/mitras/:id' do
    context 'as master admin' do
      include_context 'with authenticated master admin'
      let(:mitra) { create(:mitra) }

      it 'soft deletes the mitra' do
        delete "/api/v1/mitras/#{mitra.id}"
        expect(response).to have_http_status(:no_content)
        expect(mitra.reload).to be_inactive
      end
    end
  end
end
