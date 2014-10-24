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
    from1 { Faker::Time.forward(23, :day).strftime('%H:%M') }
    to1 { Faker::Time.forward(23, :day).strftime('%H:%M') }
    participants { Faker::Number.number(2) }
    cellphone { Faker::PhoneNumber.cell_phone }
  end
end
