Feature: edit guidedtour
  In order to edit guided tour
  As an accounter, admin or dbuser
  I want to be able to change some data via form

  Background:
    Given I am logged in as an dbuser
    And There is an opened guidedtour
    And I am on the homepage
    When I follow "Offene Rundgänge"
    And I follow image_link "Bearbeiten" for this guidedtour

  Scenario: edit with valid params
    Then I should see title "Rundgang - Datenänderung"
    And I should see "Rundgang - Datenänderung"
    When I choose "guidedtour_gender_mrs"
    And I fill in "Vorname" with "John"
    And I fill in "Handynummer der Begleitperson" with "55555555"
    And I press "Speichern"
    Then Show me the page
    Then I should see "Geführter Rundgang wurde geändert"
