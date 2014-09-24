FactoryGirl.define do
  factory :role do
    title { (Faker::Name.title.split(" ")).last }

    factory :dbuser_role do
      title 'dbuser'
    end
    factory :admin_role do
      title 'admin'
    end
    factory :reader_role do
      title 'reader'
    end
    factory :referent_role do
      title 'referent'
    end
    factory :accounter_role do
      title 'dbuser'
    end
  end
end
