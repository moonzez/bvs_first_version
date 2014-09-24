FactoryGirl.define do
  factory :language do
    language { Faker::Lorem.word }

    factory :english do
      language 'Englisch'
    end

    factory :german do
      language 'Deutsch'
    end

    factory :russian do
      language 'Russisch'
    end

  end
end
