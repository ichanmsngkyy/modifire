FactoryBot.define do
  factory :notification do
    user { nil }
    actor_id { 1 }
    notifiable_type { "MyString" }
    notifiable_integer { "MyString" }
    read { false }
    message { "MyString" }
  end
end
