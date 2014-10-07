@javascript
Feature: deleting referent language
  In order to remove unused languages
  As an accounter, admin or dbuser
  I want to do it via button click

  Background:
    Given There is a language "Deutsch"
    And There is a language "Englisch"
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|activ|
      |Deba|Meba|deba.meba@bvs.de|765432|activ|
    And User "deba.meba@bvs.de" speeks languages:
      |language|
      |Deutsch|
    And I am logged in as an dbuser
    And I am on the homepage
    And I put mouseover "Referent"
    And I follow "Sprachen"

  Scenario: delete not used language
    Then I should see "Englisch"
    When I follow "Englisch löschen"
    Then I should not see "Englisch"

  Scenario: trying to delete used language
    Then I should see "Deutsch"
    When I follow "Deutsch löschen"
    Then I should see alert "Deutsch kann nicht gelöscht werden: ist in Verwendung"
    And I should see "Deutsch"
