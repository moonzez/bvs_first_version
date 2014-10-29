Given(/^There are guidedtours:$/) do |table|
  table.hashes.each do |attributes|
    attributes['created_at'] = eval(attributes['created_at']) if attributes['created_at']
    attributes['date1'] = (eval(attributes['date1'])).strftime('%Y-%m-%d') if attributes['date1'].present?
    attributes['date2'] = (eval(attributes['date2'])).strftime('%Y-%m-%d') if attributes['date2'].present?
    attributes['date3'] = (eval(attributes['date3'])).strftime('%Y-%m-%d') if attributes['date3'].present?
    attributes['from2'] = (eval(attributes['from2'])) if attributes['from2'].present?
    attributes['from3'] = (eval(attributes['from3'])) if attributes['from3'].present?
    attributes['to2'] = (eval(attributes['to2'])) if attributes['to2'].present?
    attributes['to3'] = (eval(attributes['to3'])) if attributes['to3'].present?
    @guidedtour = FactoryGirl.create(:guidedtour, attributes)
  end
end

Given(/^There is an opened guidedtour$/) do
  @guidedtour = FactoryGirl.create(:guidedtour, state: :opened)
end

When(/^I follow image_link "(.*?)" for this guidedtour$/) do |title|
  if title == 'Bearbeiten'
    link = edit_guidedtour_path(@guidedtour)
  elsif title == 'Löschen'
    link = guidedtour_path(@guidedtour)
  else
    throw 'NotDefined'
  end
  find(:xpath, "//a[@href='#{link}'][@title='#{title}']").click
end
