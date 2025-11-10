require 'rails_helper'

RSpec.describe User, type: :model do
  # Create a valid user for shoulda-matchers uniqueness tests
  subject { create(:user) }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end

  describe 'callbacks' do
    it 'generates jti before creation' do
      user = build(:user, jti: nil)
      expect(user.jti).to be_nil
      user.save
      expect(user.jti).to be_present
      expect(user.jti).to match(/\A[a-f0-9\-]{36}\z/)
    end
  end

  describe 'devise modules' do
    it 'includes required devise modules' do
      expect(User.devise_modules).to include(
        :database_authenticatable,
        :registerable,
        :validatable,
        :jwt_authenticatable
      )
    end
  end

  describe '.find_for_database_authentication' do
    let!(:user) { create(:user, username: 'testuser') }

    it 'find user by username' do
      found_user = User.find_for_database_authentication(username: 'testuser')
      expect(found_user).to eq(user)
    end
  end
end
