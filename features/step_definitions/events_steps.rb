When(/^I fill in datepicker "(.*?)" with "(.*?)"$/) do |datepicker_id, value|
  time_value = Time.now.strftime('%Y-%m-%d')
  time_value = 1.day.from_now.strftime('%Y-%m-%d') if value == 'tomorrow'

  page.execute_script("$('#" + datepicker_id + "').val('#" + time_value + "')")
end

When(/^I fill in time "(.*?)" with "(.*?)"$/) do |time_id, _value|
  all("##{ time_id } option")[1].select_option
end

Then(/^I should see date "(.*?)"$/) do |date|
  expect(page).to have_content(I18n.l(eval(date)))
end

Then(/^I should see state "(.*?)"$/) do |state|
  expect(page).to have_select('Status', selected: state)
end

When(/^I select state "(.*?)" for "(.*?)"$/) do |state, event|
  select state, :from => "#{event}_state"
end
