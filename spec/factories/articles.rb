FactoryBot.define do
  factory :article do
    title { "MyString" }
    slug { "MyString" }
    published { false }
    user { nil }
  end
end
