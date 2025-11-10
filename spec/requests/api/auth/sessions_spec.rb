require 'rails_helper'

RSpec.describe "Api::Auth::Sessions", type: :request do
  describe "POST /api/auth/login" do
    let!(:user) { create(:user, username: 'testuser', password: 'password123') }

    context 'with valid credentials' do
      let(:valid_attributes) do
      {
      user: {
      username: 'testuser',
      password: 'password123'
      }
      }
      end

      it 'returns user data in response body' do
        post '/api/auth/login', params: valid_attributes
        expect(response).to have_http_status(:ok)
        expect(json['status']['message']).to eq('Logged in successfully.')
        expect(json['data']['username']).to eq(user.username)
      end

      it 'returns JWT token in header' do
        post '/api/auth/login', params: valid_attributes
        expect(response.header['Authorization']).to be_present
        expect(response.header['Authorization']).to start_with('Bearer')
      end
    end

    context 'with invalid credentials' do
      it 'returns error for invalid username' do
        post '/api/auth/login', params: {
          user: { username: 'example', password: 'password123' }
        }
        expect(response).to have_http_status(:unauthorized)
      end

      it 'returns error for invalid password' do
        post '/api/auth/login', params: {
          user: { username: 'testuser', password: 'hakdog' }
        }
        expect(response).to have_http_status(:unauthorized)
        expect(json['status']['message']).to eq('Invalid username or password.')
      end
    end

    context 'with missing parameters' do
      it 'returns error when username is missing' do
        post '/api/auth/login', params: {
        user: { username: nil, password: 'password123' }
        }
        expect(response).to have_http_status(:unauthorized)
        expect(json['status']['message']).to eq('Invalid username or password.')
      end

      it 'returns error when password is missing' do
        post '/api/auth/login', params: {
        user: { username: 'testuser', password: 'nil' }
        }
        expect(response).to have_http_status(:unauthorized)
        expect(json['status']['message']).to eq('Invalid username or password.')
      end
    end
  end
end
