Then(/^I should see alert "(.*?)"$/) do |text|
  expect(page.driver.browser.switch_to.alert.text).to eql text
  page.driver.browser.switch_to.alert.accept
end
