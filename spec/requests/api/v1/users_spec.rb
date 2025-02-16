require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  let(:valid_attributes) do
    {
      email: 'test@example.com',
      password: 'password123',
      password_confirmation: 'password123',
      role: 'customer',
      profile_data: { name: 'Test User' }
    }
  end

  describe 'POST /api/v1/users' do
    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post '/api/v1/users', params: { user: valid_attributes }
        }.to change(User, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a user' do
        expect {
          post '/api/v1/users', params: { user: valid_attributes.merge(email: '') }
        }.not_to change(User, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /api/v1/users/me' do
    let(:user) { create(:user) }

    context 'when authenticated' do
      before { sign_in user }

      it 'returns the current user' do
        get '/api/v1/users/me'
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['email']).to eq(user.email)
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        get '/api/v1/users/me'
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT /api/v1/users/me' do
    let(:user) { create(:user) }

    context 'when authenticated' do
      before { sign_in user }

      it 'updates the user profile' do
        put '/api/v1/users/me', params: { user: { profile_data: { name: 'Updated Name' } } }
        expect(response).to have_http_status(:ok)
        expect(user.reload.profile_data['name']).to eq('Updated Name')
      end
    end

    context 'when not authenticated' do
      it 'returns unauthorized' do
        put '/api/v1/users/me', params: { user: { profile_data: { name: 'Updated Name' } } }
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
