Given(/^There is a language "(.*?)"$/) do |language|
  @language = FactoryGirl.create(:language, language: language)
end

When(/^(?:|I )check language "([^"]*)"$/) do |language|
  language_id = Language.find_by(language: language).id
  find(:css, "#language_#{language_id}").set(true)
end
