
require 'rails_helper'

RSpec.describe BuildAttachment, type: :model do
  it { should belong_to(:build) }
  it { should belong_to(:attachment) }

  it "is valid with valid attributes" do
    build = create(:build)
    attachment = create(:attachment)
    build_attachment = BuildAttachment.new(build: build, attachment: attachment)
    expect(build_attachment).to be_valid
  end

  it "is not valid without a build" do
    attachment = create(:attachment)
    build_attachment = BuildAttachment.new(attachment: attachment)
    expect(build_attachment).not_to be_valid
  end

  it "is not valid without an attachment" do
    build = create(:build)
    build_attachment = BuildAttachment.new(build: build)
    expect(build_attachment).not_to be_valid
  end
end
