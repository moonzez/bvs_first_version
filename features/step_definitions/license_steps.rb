Given(/^There is a license "(.*?)" "(.*?)"$/) do |title, shortcut|
  FactoryGirl.create(:license, title: title, shortcut: shortcut)
end

When(/^I check license "(.*?)"$/) do |shortcut|
  license_id = License.find_by(shortcut: shortcut).id
  find(:css, "#license_#{license_id}").set(true)
end

When(/^I uncheck license "(.*?)"$/) do |shortcut|
  license_id = License.find_by(shortcut: shortcut).id
  find(:css, "#license_#{license_id}").set(false)
end
