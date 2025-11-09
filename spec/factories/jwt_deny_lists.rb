FactoryBot.define do
  factory :jwt_deny_list do
    jti { "MyString" }
    exp { "2025-11-10 02:46:16" }
  end
end
