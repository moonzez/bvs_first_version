@javascript
Feature: edit guidedtour
  In order to edit guided tour
  As an accounter, admin or dbuser
  I want to be able to change some data via form

  Background:
    Given I am logged in as an admin
    And There are guidedtours:
      |lastname|schoolname|city|participants|
      |Doe|Myschoolname|Mycity|12|
    And I am on the homepage
    When I put mouseover "Rundgänge"
    And I follow "Offene Rundgänge"

  Scenario: delete guided tour
    Then I should see "Doe"
    And I should see "Myschoolname"
    And I should see "Mycity"
    And I should see "12"
    When I follow image_link "Löschen" for this guidedtour
    Then I should see alert "Geführten Rundgang löschen?"
    When I accept alert
    Then I should see alert "Geführter Rundgang wurde gelöscht"
    And I accept alert
    Then I should not see "Doe"
    And I should not see "Myschoolname"
    And I should not see "Mycity"
    And I should not see "12"

  Scenario: do not delete guided tour
    Then I should see "Doe"
    And I should see "Myschoolname"
    And I should see "Mycity"
    And I should see "12"
    When I follow image_link "Löschen" for this guidedtour
    Then I should see alert "Geführten Rundgang löschen?"
    When I dismiss alert
    Then I should see "Doe"
    And I should see "Myschoolname"
    And I should see "Mycity"
    And I should see "12"
