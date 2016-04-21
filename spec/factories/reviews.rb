FactoryGirl.define do
  factory :review do
    association :user, factory: :user
    body "MyText"
    stars 1.5
  end
end
