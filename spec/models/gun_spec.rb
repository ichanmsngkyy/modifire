
require 'rails_helper'

RSpec.describe Gun, type: :model do
  it { should have_many(:gun_attachments) }
  it { should have_many(:attachments).through(:gun_attachments) }
  it { should have_many(:builds) }

  it "is valid with valid attributes" do
    gun = build(:gun)
    expect(gun).to be_valid
  end

  it "is not valid without a name" do
    gun = build(:gun, name: nil)
    expect(gun).not_to be_valid
  end

  it "is not valid without a category" do
    gun = build(:gun, category: nil)
    expect(gun).not_to be_valid
  end
end
