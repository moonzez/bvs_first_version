@javascript
Feature: Deleting users
  In order to remove unneeded user
  As an admin
  I want to be able to delete user

  Background:
    Given There are the following users with role "dbuser":
      |firstname|lastname|email|tel|
      |Aba|Dbuser|aba.dbuser@bvs.de|1234567|
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|
      |Deba|Meba|deba.meba@bvs.de|765432|
    Given I am logged in as admin "suicide.me@bvs.de"
    And I am on the homepage
    Given I follow "Nutzer"

  Scenario: remove myself
    When I follow image_link "Löschen" for user "suicide.me@bvs.de"
    Then I should see alert "Suicide Me löschen?"
    And I accept alert
    And I should see alert "Sie können eigenes Profil nicht löschen"
    And I accept alert
    And I should see "suicide.me@bvs.de"

  Scenario: removing referent
    When I follow image_link "Löschen" for user "deba.meba@bvs.de"
    Then I should see alert "Deba Meba löschen?"
    And I accept alert
    And I should see alert "Referent Deba Meba darf nicht gelöscht werden"
    And I accept alert
    And I should see "deba.meba@bvs.de"

  Scenario: removing dbuser
    When I follow image_link "Löschen" for user "aba.dbuser@bvs.de"
    Then I should see alert "Aba Dbuser löschen?"
    And I accept alert
    And I should see alert "Nutzer Aba Dbuser wurde gelöscht"
    And I accept alert
    Then I should not see "aba.dbuser@bvs.de"
