Given(/^There is a license "(.*?)" "(.*?)"$/) do |title, shortcut|
  FactoryGirl.create(:license, title: title, shortcut: shortcut)
end
