class BuildAttachment < ApplicationRecord
  belongs_to :build
  belongs_to :attachment
end
