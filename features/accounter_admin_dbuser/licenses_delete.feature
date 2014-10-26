@javascript
Feature: deleting referent licenses
  In order to remove unused licenses
  As an accounter, admin or dbuser
  I want to do it via button click

  Background:
    Given There is a license "This is a new license A" "License A"
    And There is a license "This is a new license B" "License B"
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|activ|
      |Deba|Meba|deba.meba@bvs.de|765432|activ|
    And User "deba.meba@bvs.de" has licenses:
      |title|shortcut|
      |This is a new license B|License B|

    And I am logged in as an dbuser
    And I am on the homepage
    And I put mouseover "Referent"
    And I follow "Lizenzen"

  Scenario: delete not used license
    Then I should see "License A"
    When I follow "License A löschen"
    Then I should not see "License A"

  Scenario: trying to delete used license
    Then I should see "License B"
    When I follow "License B löschen"
    Then I should see alert "License B kann nicht gelöscht werden: ist in Verwendung"
    And I accept alert
    Then I should see "License B"
