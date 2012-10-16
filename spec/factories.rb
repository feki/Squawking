FactoryGirl.define do
  factory :user do |user|
    email                 "jan.gabela@gmail.com"
    password              "password"
    password_confirmation "password"
  end

  factory :comment do |comment|
    content     "Some comment"
    association :commentable
    association :user
  end

  factory :answer do |answer|
    content     "Some answer"
    association :user
    association :question
  end

  factory :question do |question|
    content     "Some question"
    association :user
  end

  factory :reaction do |reaction|
    content     "Some reaction"
    association :user
  end
end