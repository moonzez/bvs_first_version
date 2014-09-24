Given /^There are the following users:$/ do |table|
  table.hashes.each do |attributes|
    @user = FactoryGirl.create(:user, attributes)
  end
end

Given /^I am signed in as them$/ do
  steps(%Q{
    Given I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "#{@user.email}"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Signed in successfully."
  })
end
