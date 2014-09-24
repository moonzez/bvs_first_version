Feature:
  In order to use the application
  As a user
  I want to be able to login

  Background:
    Given There are the following users:
      |username|password|
      |john.doe|password|
    Given I am on the login

  Scenario: Log in with valid data
    When I fill in "Login" with "john.doe"
    And I fill in "Password" with "password"
    And I press "Anmelden"
    Then I should see "Sie sind angemeldet"
    And I follow "Abmelden"
    Then I should see "Sie sind abgemeldet"
    And I should see "Anmelden"
    And I should see "Login"
    And I should see "Password"


  Scenario: Log in with invalid password
    When I fill in "Login" with "john.doe"
    And I fill in "Password" with "wrong password"
    And I press "Anmelden"
    Then I should see "Password ist falsch"

  Scenario: Log in with invalid login
    When I fill in "Login" with "johndoe"
    And I fill in "Password" with "password"
    And I press "Anmelden"
    Then I should see "Login ist falsch"
