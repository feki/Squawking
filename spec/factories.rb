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
    association :project
  end

  factory :reaction do |reaction|
    content     "Some reaction"
    association :user
    association :article
  end

  factory :article do |article|
    content     "Some article"
    title       "Some title"
    association :user
    association :project
  end

  factory :project do |project|
    name        "some name"
    description "Some description of project"
  end
end