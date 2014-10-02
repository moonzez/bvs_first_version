Given(/^There are the following users:$/) do |table|
  table.hashes.each do |attributes|
    @user = FactoryGirl.create(:user, attributes)
  end
end

Given(/^There are the following users with role "(.+)":$/) do |role, table|
  table.hashes.each do |attributes|
    @user = FactoryGirl.create(role.to_sym, attributes)
  end
end
