FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    gender :herr
    email { Faker::Internet.email }
    tel { Faker::PhoneNumber.cell_phone }
    username { Faker::Internet.user_name }
    password { Faker::Internet.password }
    password_confirmation { |u| u.password }

    factory :invalid_user, parent: :user do
      email nil
      tel nil
    end

    factory :admin do
      roles { [ Role.find_by(title: "admin") || FactoryGirl.create(:admin_role) ] }
    end

    factory :dbuser do
      roles { [ Role.find_by(title: "dbuser") || FactoryGirl.create(:dbuser_role) ] }
    end

    factory :reader do
      roles { [ Role.find_by(title: "reader") || FactoryGirl.create(:reader_role)] }
    end

    factory :accounter do
      roles { [ Role.find_by(title: "accounter") || FactoryGirl.create(:accounter_role) ] }
    end

    factory :referent do
      bank { Faker::Company.name }
      blz { Faker::Company.ein }
      konto { Faker::Company.ein }
      roles { [ Role.find_by(title: "referent") || FactoryGirl.create(:referent_role) ] }
    end
  end
end
