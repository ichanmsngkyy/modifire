
require 'rails_helper'

RSpec.describe Attachment, type: :model do
  it { should have_many(:build_attachments) }
  it { should have_many(:builds).through(:build_attachments) }
  it { should have_many(:gun_attachments) }
  it { should have_many(:guns).through(:gun_attachments) }

  it "is valid with valid attributes" do
    attachment = build(:attachment)
    expect(attachment).to be_valid
  end

  it "is not valid without a name" do
    attachment = build(:attachment, name: nil)
    expect(attachment).not_to be_valid
  end

  it "is not valid without an attachment_type" do
    attachment = build(:attachment, attachment_type: nil)
    expect(attachment).not_to be_valid
  end
end
