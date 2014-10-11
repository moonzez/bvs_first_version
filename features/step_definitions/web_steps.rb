Given(/^I am on the (.+)$/) do |page_name|
  visit path_to(page_name)
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in(field, with: value)
end

Then(/^I should see field "(.*?)" with "(.*?)"$/) do |field, value|
  find("input[id='profile_#{field}'][value='#{value}']")
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

Then(/^Show me the page$/) do
  save_and_open_page
end

When(/^I follow "(.*?)"$/) do |link|
  first(:link, link).click
end

Given(/^I am logged in as (.*) "(.+)"$/) do |user, email|
  name = email.split('@').first
  firstname, lastname = name.split('.').map(&:downcase).map(&:capitalize)
  if firstname && lastname
    @user = FactoryGirl.create(
      user.to_sym, email: email, firstname: firstname, lastname: lastname
    )
  else
    @user = FactoryGirl.create(user.to_sym, email: email, firstname: firstname)
  end
  steps(%(
    Given I am on the login
    When I fill in "Login" with "#{@user.username}"
    And I fill in "Password" with "#{@user.password}"
    And I press "Anmelden"
    Then I should see "Sie sind angemeldet"
  ))
end

Given(/^I am logged in as an (.+)$/) do |user|
  @user = FactoryGirl.create(user.to_sym)
  steps(%(
    Given I am on the login
    When I fill in "Login" with "#{@user.username}"
    And I fill in "Password" with "#{@user.password}"
    And I press "Anmelden"
    Then I should see "Sie sind angemeldet"
  ))
end

When(/^I choose \("(.*?)"\)$/) do |radio|
  choose(radio)
end

When(/^(?:|I )check \("(.*?)"\)$/) do |checkbox|
  find(:css, "##{checkbox}").set(true)
end

Then(/^(?:|I )should see title "([^"]*)"$/) do |text|
  expect(page).to have_title(text)
end

Then(/^I should see "(.*?)" link$/) do |text|
  expect(page).to have_css('a', text: text)
end

Then(/^I should not see "(.*?)" link$/) do |text|
  expect(page).not_to have_css('a', text: text)
end

Then(/^I should see image_link "(.*?)" to "(.*?)" user "(.*?)"$/) do |title, action, email|
  user = User.find_by(email: email)
  if action == 'edit'
    expect(page).to have_xpath("//a[@title='#{title}'] [@href='#{ edit_user_path(user) }']")
  elsif action == 'destroy'
    expect(page).to have_xpath("//a[@title='#{title}'] [@href='#{user_path(user)}'] [@data-method='delete']")
  end
end

Then(/^I should not see image_link "(.*?)" to "(.*?)" user "(.*?)"$/) do |title, action, email|
  user = User.find_by(email: email)
  if action == 'edit'
    expect(page).not_to have_xpath("//a[@title='#{title}'] [@href='#{ edit_user_path(user) }']")
  elsif action == 'destroy'
    xpath = "//a[@title='#{title}'] [@href='#{user_path(user)}'] [@data-method='delete']"
    expect(page).not_to have_xpath(xpath)
  end
end

When(/^I follow image_link "(.*?)" for user "(.*?)"$/) do |title, email|
  user = User.find_by(email: email)
  if title == 'Bearbeiten'
    link = edit_user_path(user)
  elsif title == 'Löschen'
    link = user_path(user)
  end

  find(:xpath, "//a[@href='#{link}'][@title='#{title}']").click
end

Then(/^I should see image_link "(.*?)" for referent "(.*?)"$/) do |title, email|
  referent = User.find_by(email: email)
  if title == 'Temporär deaktivieren'
    href = change_activ_referent_path(referent, activ: 'temporary')
  elsif title == 'Deaktivieren'
    href = change_activ_referent_path(referent, activ: 'inactiv')
  elsif title == 'Aktivieren'
    href = change_activ_referent_path(referent, activ: 'activ')
  elsif title == 'Bearbeiten'
    href = edit_referent_path(referent)
  elsif title == 'Löschen'
    href = remove_referent_path(referent)
  end
  expect(page).to have_xpath("//a[@title='#{ title }'] [@href='#{ href }']")
end

Then(/^I should not see image_link "(.*?)" for referent "(.*?)"$/) do |title, email|
  referent = User.find_by(email: email)
  if title == 'Temporär deaktivieren'
    href = change_activ_referent_path(referent, activ: 'temporary')
  elsif title == 'Deaktivieren'
    href = change_activ_referent_path(referent, activ: 'inactiv')
  elsif title == 'Aktivieren'
    href = change_activ_referent_path(referent, activ: 'activ')
  elsif title == 'Bearbeiten'
    href = edit_referent_path(referent)
  elsif title == 'Löschen'
    href = remove_referent_path(referent)
  end
  expect(page).not_to have_xpath("//a[@title='#{ title }'] [@href='#{ href }']")
end

When(/^I follow image_link "(.*?)" for referent "(.*?)"$/) do |title, email|
  referent = User.find_by(email: email)
  if title == 'Temporär deaktivieren'
    link = change_activ_referent_path(referent, activ: 'temporary')
  elsif title == 'Deaktivieren'
    link = change_activ_referent_path(referent, activ: 'inactiv')
  elsif title == 'Aktivieren'
    link = change_activ_referent_path(referent, activ: 'activ')
  elsif title == 'Bearbeiten'
    link = edit_referent_path(referent)
  elsif title == 'Löschen'
    link = remove_referent_path(referent)
  end

  find(:xpath, "//a[@href='#{link}'][@title='#{title}']").click
end
