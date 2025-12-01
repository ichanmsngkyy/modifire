
require 'rails_helper'

RSpec.describe JwtDenyList, type: :model do
  it "is valid with valid attributes" do
    jwt = build(:jwt_deny_list)
    expect(jwt).to be_valid
  end

  it "is not valid without a jti" do
    jwt = build(:jwt_deny_list, jti: nil)
    expect(jwt).not_to be_valid
  end

  it "is not valid without an exp" do
    jwt = build(:jwt_deny_list, exp: nil)
    expect(jwt).not_to be_valid
  end
end
