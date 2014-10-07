Then(/^I should see alert "(.*?)"$/) do |text|
  expect(page.driver.browser.switch_to.alert.text).to eql text
  page.driver.browser.switch_to.alert.accept
end

Given(/^I put mouseover "(.*?)"$/) do |text|
  find('a', text: text).hover
end
