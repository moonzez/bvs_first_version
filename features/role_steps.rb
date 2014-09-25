Given(/^there is a role "(.*?)"$/) do |role|
  new_role = role + "_role"
  FactoryGirl.create(new_role.to_sym)
end
