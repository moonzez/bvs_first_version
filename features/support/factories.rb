FactoryGirl.factories.clear
Dir[Rails.root + "factories/*.rb"].each do |file|
  require file
end
