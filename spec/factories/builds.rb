FactoryBot.define do
  factory :build do
    user { nil }
    gun { nil }
    name { "MyString" }
    slug { "MyString" }
    is_public { false }
    likes_count { 1 }
  end
end
