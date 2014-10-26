Given(/^There are guidedtours:$/) do |table|
  table.hashes.each do |attributes|
    attributes['created_at'] = eval(attributes['created_at']) if  attributes['created_at']
    attributes['date1'] = (eval(attributes['date1'])).strftime('%Y-%m-%d') if  attributes['date1'].present?
    attributes['date2'] = (eval(attributes['date2'])).strftime('%Y-%m-%d') if  attributes['date2'].present?
    attributes['date3'] = (eval(attributes['date3'])).strftime('%Y-%m-%d') if  attributes['date3'].present?
    @guidedtour = FactoryGirl.create(:guidedtour, attributes)
  end
end
