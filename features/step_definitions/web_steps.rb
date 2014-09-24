Given /^I am on the (.+)$/ do |page_name|
  visit path_to(page_name)
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field, :with => value)
end

When(/^I press "(.*?)"$/) do |button|
  click_button(button)
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end

Then(/^I should not see "(.*?)"$/) do |text|
  expect(page).not_to have_content(text)
end

Then /^Show me the page$/ do
  save_and_open_page
end

When(/^I follow "(.*?)"$/) do |link|
  first(:link, link).click
end

Given(/^I am logged in as an (.*?)$/) do |user|
  @user = FactoryGirl.create(user.to_sym)
  steps(%Q{
    Given I am on the login
    When I fill in "Login" with "#{@user.username}"
    And I fill in "Password" with "#{@user.password}"
    And I press "Anmelden"
    Then I should see "Sie sind angemeldet"
  })
end
