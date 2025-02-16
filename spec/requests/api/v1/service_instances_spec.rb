require 'rails_helper'

RSpec.describe 'Api::V1::ServiceInstances', type: :request do
  let(:service_template) { create(:service_template) }
  let(:valid_attributes) do
    {
      name: 'Test Instance',
      description: 'Test Description',
      pricing_details: { base_price: 12000, per_km: 2500 },
      service_area: { center: { lat: -6.2088, lng: 106.8456 }, radius: 5000 },
      service_template_id: service_template.id
    }
  end

  describe 'GET /api/v1/mitras/:mitra_id/service_instances' do
    context 'as master admin' do
      include_context 'with authenticated master admin'
      let(:mitra) { create(:mitra) }
      let!(:service_instances) { create_list(:service_instance, 3, mitra: mitra) }

      it 'returns all service instances for the mitra' do
        get "/api/v1/mitras/#{mitra.id}/service_instances"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end

    context 'as mitra admin' do
      include_context 'with authenticated mitra admin'
      let!(:service_instances) { create_list(:service_instance, 3, mitra: administered_mitra) }

      it 'returns service instances for administered mitra' do
        get "/api/v1/mitras/#{administered_mitra.id}/service_instances"
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end
  end

  describe 'POST /api/v1/mitras/:mitra_id/service_instances' do
    context 'as mitra admin' do
      include_context 'with authenticated mitra admin'

      it 'creates a new service instance' do
        expect {
          post "/api/v1/mitras/#{administered_mitra.id}/service_instances",
               params: { service_instance: valid_attributes }
        }.to change(ServiceInstance, :count).by(1)
        expect(response).to have_http_status(:created)
      end

      it 'returns validation errors for invalid data' do
        post "/api/v1/mitras/#{administered_mitra.id}/service_instances",
             params: { service_instance: valid_attributes.merge(name: '') }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /api/v1/mitras/:mitra_id/service_instances/:id' do
    context 'as mitra admin' do
      include_context 'with authenticated mitra admin'
      let(:service_instance) { create(:service_instance, mitra: administered_mitra) }

      it 'updates the service instance' do
        put "/api/v1/mitras/#{administered_mitra.id}/service_instances/#{service_instance.id}",
            params: { service_instance: { name: 'Updated Name' } }
        expect(response).to have_http_status(:ok)
        expect(service_instance.reload.name).to eq('Updated Name')
      end
    end
  end

  describe 'DELETE /api/v1/mitras/:mitra_id/service_instances/:id' do
    context 'as mitra admin' do
      include_context 'with authenticated mitra admin'
      let(:service_instance) { create(:service_instance, mitra: administered_mitra) }

      it 'archives the service instance' do
        delete "/api/v1/mitras/#{administered_mitra.id}/service_instances/#{service_instance.id}"
        expect(response).to have_http_status(:no_content)
        expect(service_instance.reload).to be_archived
      end
    end
  end
end
