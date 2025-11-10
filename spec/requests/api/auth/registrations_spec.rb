require 'rails_helper'

RSpec.describe "Api::Auth::Registrations", type: :request do
  describe 'POST /api/auth/signup' do
    let(:valid_attributes) do
      {
        user: {
          username: 'newuser',
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new user' do
        expect {
          post '/api/auth/signup', params: valid_attributes
        }.to change(User, :count).by(1)
      end

      it 'returns a success response' do
        post '/api/auth/signup', params: valid_attributes
        expect(response).to have_http_status(:ok)
        expect(json['status']['message']).to eq('Signed up successfully.')
        expect(json['data']).to have_key('username')
        expect(json['data']).to have_key('email')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a user with invalid email' do
        invalid_params = valid_attributes.deep_dup
        invalid_params[:user][:email] = 'invalid'

        expect {
          post '/api/auth/signup', params: invalid_params
        }.not_to change(User, :count)
      end

      it 'returns error for short password' do
        invalid_params = valid_attributes.deep_dup
        invalid_params[:user][:password] = '123'
        invalid_params[:user][:password_confirmation] = '123'

        post '/api/auth/signup', params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['status']['message']).to include('Password')
      end

      it 'returns error for duplicates username' do
        create(:user, username: 'newuser')
        post '/api/auth/signup', params: valid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['status']['message']).to include('Username has already been taken')
      end

      it 'returns error for duplicate email' do
        create(:user, email: 'test@example.com')
        post '/api/auth/signup', params: valid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json['status']['message']).to include('Email has already been taken')
      end
    end
  end
end
