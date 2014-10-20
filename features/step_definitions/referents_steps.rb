Then(/^I should see checked mailto_box for referent "(.*?)"$/) do |email|
  referent_id = User.find_by(email: email).id
  element = find("input[id='mailto_#{referent_id}']")
  expect(element.checked?).to eql true
end

Then(/^I should see unchecked mailto_box for referent "(.*?)"$/) do |email|
  referent_id = User.find_by(email: email).id
  element = find("input[id='mailto_#{referent_id}']")
  expect(element.checked?).to eql false
end

When(/^I check mailto_box for all$/) do
  find(:css, "input[id='mail_all']").set(true)
end

When(/^I check mailto_box for referent "(.*?)"$/) do |email|
  referent_id = User.find_by(email: email).id
  find(:css, "input[id='mailto_#{referent_id}']").set(true)
end

When(/^I uncheck mailto_box for all$/) do
  find(:css, "input[id='mail_all']").set(false)
end
