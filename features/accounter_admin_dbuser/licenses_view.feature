Feature: Viewing all licenses
  In order to manage referents licenses
  As an accounter, admin or dbuser
  I want to see the list of all licenses

  Background:
    Given There is a license "This is a new license A" "Licinse A"
    And There is a license "This is a new license B" "Licinse B"
    And I am logged in as an dbuser
    And I am on the homepage
    And I follow "Lizenzen"

  Scenario: see the list of all lizenses
    Then I should see title "Alle Lizenzen für Referenten"
    And I should see "This is a new license A"
    And I should see "Licinse A"
    And I should see "This is a new license B"
    And I should see "Licinse B"
