Feature: Creating new referent language
  In order add new languages
  As an accounter, admin or dbuser
  I want to do it via button click

  Background:
    Given There is a language "Deutsch"
    And There is a language "Englisch"
    And I am logged in as an dbuser
    And I am on the homepage
    And I follow "Sprachen"

  Scenario: add new language
    When I fill in "Sprache" with "Italienisch"
    And I press "Speichern"
    Then I should see "Italienisch wurde angelegt"

  Scenario: trying to create already existent language
    When I fill in "Sprache" with "Deutsch"
    And I press "Speichern"
    Then I should see "Neue Sprache wurde nicht angelegt: Sprache ist bereits verwendet"
