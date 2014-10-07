@javascript
Feature: Deleting referents
  In order to remove unneeded referents
  As an accounter, admin or dbuser
  I want to be able to delete referent

  Background:
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|
      |Deba|Withevent|deba.withevent@bvs.de|765432|
      |Meba|Without|meba.without@bvs.de|765432|
    Given I am logged in as an admin
    And I am on the homepage
    Given I follow "Referenten"

  Scenario: remove referent with assigned event
    When I follow image_link "Löschen" for referent "deba.withevent@bvs.de"
    And I should see alert "Deba Withevent löschen?"
    And I should see alert "Referent Deba Withevent darf nicht gelöscht werden"
    Then I should see "deba.withevent@bvs.de"

  Scenario: remove referent without assigned event
    #TODO
    #When I follow image_link "Löschen" to referent "meba.without@bvs.de"
    #And I should see "Referent wurde gelöscht wurde gelöscht werden"
    #Then I should not see "deba.withevent@bvs.de"
