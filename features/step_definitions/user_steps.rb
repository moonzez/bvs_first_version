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

Given(/^User "(.*?)" speeks languages:$/) do |email, table|
  user = User.find_by(email: email)
  table.hashes.each do |attributes|
    language = Language.find_by(language: attributes[:language]) ||
      FactoryGirl.create(:language, attributes)
    user.languages << language
  end
end

Given(/^User "(.*?)" has licenses:$/) do |email, table|
  user = User.find_by(email: email)
  table.hashes.each do |attributes|
    license = License.find_by(shortcut: attributes[:shortcut]) ||
      FactoryGirl.create(:license, attributes)
    user.licenses << license
  end
end
