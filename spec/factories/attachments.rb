FactoryBot.define do
  factory :attachment do
    name { "MyString" }
    attachment_type { "MyString" }
    description { "MyText" }
    layer_order { 1 }
    x_position { 1 }
    y_position { 1 }
  end
end
