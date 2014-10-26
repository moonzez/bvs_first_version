Then(/^I should see alert "(.*?)"$/) do |text|
  expect(page.driver.browser.switch_to.alert.text).to eql text
end

Then(/^I accept alert/) do
  page.driver.browser.switch_to.alert.accept
end

Then(/^I dismiss alert/) do
  page.driver.browser.switch_to.alert.dismiss
end

Given(/^I put mouseover "(.*?)"$/) do |text|
  find('a', text: text).hover
end
