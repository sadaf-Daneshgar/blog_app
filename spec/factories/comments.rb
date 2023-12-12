FactoryBot.define do
  factory :comment do
    text { 'It is realy nice!' }
    association :author, factory: :user
    association :post, factory: :post
  end
end
