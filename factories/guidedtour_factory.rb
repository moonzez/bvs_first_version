FactoryGirl.define do
  factory :guidedtour do
    gender :mr
    firstname { Faker::Name.first_name }
    lastname { Faker::Name.last_name }
    email { Faker::Internet.email }
    schoolname { Faker::Company.name }
    street { Faker::Address.street_address }
    city { Faker::Address.city }
    zip { Faker::Address.zip_code }
    country { Faker::Address.country }
    date1 { Faker::Date.forward(23).strftime('%Y-%m-%d') }
    from1 { GT_FROMINTERN.sample }
    to1 { GT_TOINTERN.sample }
    participants { Faker::Number.number(2) }
    cellphone { Faker::PhoneNumber.cell_phone }
  end
end
