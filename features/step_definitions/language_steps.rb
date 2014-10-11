Given(/^There is a language "(.*?)"$/) do |language|
  @language = FactoryGirl.create(:language, language: language)
end

When(/^(?:|I )check language "([^"]*)"$/) do |language|
  language_id = Language.find_by(language: language).id
  find(:css, "#language_#{language_id}").set(true)
end

Then(/^I see checked language "(.*?)"$/) do |language|
  language_id = Language.find_by(language: language).id
  element = find("input[id='language_#{language_id}']")
  expect(element.checked?).to eql 'checked'
end

Then(/^I see unchecked language "(.*?)"$/) do |language|
  language_id = Language.find_by(language: language).id
  element = find("input[id='language_#{language_id}']")
  expect(element.checked?).not_to eql 'checked'
end
