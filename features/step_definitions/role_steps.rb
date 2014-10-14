Given(/^There is a role "(.*?)"$/) do |role|
  new_role = role + '_role'
  FactoryGirl.create(new_role.to_sym)
end

When(/^I check role "(.*?)"$/) do |title|
  role_id = Role.find_by(title: title).id
  find(:css, "#role_#{role_id}").set(true)
end

When(/^I uncheck role "(.*?)"$/) do |title|
  role_id = Role.find_by(title: title).id
  find(:css, "#role_#{role_id}").set(false)
end
