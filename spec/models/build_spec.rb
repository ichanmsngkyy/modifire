
require 'rails_helper'

RSpec.describe Build, type: :model do
  it { should have_many(:build_attachments) }
  it { should have_many(:attachments).through(:build_attachments) }
  it { should belong_to(:gun) }
  it { should belong_to(:user) }

  it "is valid with valid attributes" do
    user = create(:user)
    gun = create(:gun)
    build = Build.new(user: user, gun: gun)
    expect(build).to be_valid
  end

  it "is not valid without a user" do
    gun = create(:gun)
    build = Build.new(gun: gun)
    expect(build).not_to be_valid
  end

  it "is not valid without a gun" do
    user = create(:user)
    build = Build.new(user: user)
    expect(build).not_to be_valid
  end
end
