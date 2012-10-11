FactoryGirl.define do
  factory :user do |user|
    email                 "jan.gabela@gmail.com"
    password              "password"
    password_confirmation "password"
  end

  factory :comment do |comment|
    content     "Some comment"
    association :user
  end
end