Given(/^There is a role "(.*?)"$/) do |role|
  new_role = role + '_role'
  FactoryGirl.create(new_role.to_sym)
end

When(/^I check role "(.*?)"$/) do |title|
  find(:css, "#role_#{title}").set(true)
end

When(/^I uncheck role "(.*?)"$/) do |title|
  find(:css, "#role_#{title}").set(false)
end
