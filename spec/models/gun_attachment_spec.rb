
require 'rails_helper'

RSpec.describe GunAttachment, type: :model do
  it { should belong_to(:gun) }
  it { should belong_to(:attachment) }

  it "is valid with valid attributes" do
    gun = create(:gun)
    attachment = create(:attachment)
    gun_attachment = GunAttachment.new(gun: gun, attachment: attachment)
    expect(gun_attachment).to be_valid
  end

  it "is not valid without a gun" do
    attachment = create(:attachment)
    gun_attachment = GunAttachment.new(attachment: attachment)
    expect(gun_attachment).not_to be_valid
  end

  it "is not valid without an attachment" do
    gun = create(:gun)
    gun_attachment = GunAttachment.new(gun: gun)
    expect(gun_attachment).not_to be_valid
  end
end
