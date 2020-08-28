# frozen_string_literal: true

FactoryBot.define do
  factory :photo do
    
  end

  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username }
    password { Faker::Internet.password }
  end
end
