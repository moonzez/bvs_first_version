FactoryGirl.define do
  factory :license do
    title { Faker::Lorem.sentence }
    shortcut { Faker::Lorem.word }
  end
end
