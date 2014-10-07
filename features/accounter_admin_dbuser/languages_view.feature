Feature: Viewing all languages
  In order to manage referents languages
  As an accounter, admin or dbuser
  I want to see the list of all referents

  Background:
    Given There is a language "Deutsch"
    And There is a language "Englisch"
    And I am logged in as an dbuser
    And I am on the homepage
    And I follow "Sprachen"

  Scenario: see the list of all languages
    Then I should see title "BVS - Alle Sprachen für Referenten"
    Then I should see "Deutsch"
    And I should see "Englisch"
