FactoryBot.define do
  factory :post do
    title { 'Best Quotes😍' }
    text { 'It can only break you if you let it' }
    comments_counter { 0 }
    likes_counter { 0 }
    association :author, factory: :user
  end
end
