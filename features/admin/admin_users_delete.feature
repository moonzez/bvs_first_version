Feature: Deleting users
  In order to remove unneeded user
  As an admin
  I want to be able to delete user

  Background:
    Given There are the following users with role "dbuser":
      |firstname|lastname|email|tel|
      |Aba|Bduser|aba.dbuser@bvs.de|1234567|
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|
      |Deba|Referent|deba.referent@bvs.de|765432|
    Given I am logged in as admin "suicide@bvs.de"
    And I am on the homepage
    Given I follow "Nutzer"

  Scenario: remove myself
    When I follow image_link "Löschen" to user "suicide@bvs.de"
    And I should see "Sie können eigenes Profil nicht löschen"
    Then I should see "suicide@bvs.de"

  Scenario: removing referent
    When I follow image_link "Löschen" to user "deba.referent@bvs.de"
    And I should see "Deba Referent darf nicht gelöscht werden"
    Then I should see "deba.referent@bvs.de"

  Scenario: removing dbuser
    When I follow image_link "Löschen" to user "aba.dbuser@bvs.de"
    And I should see "Nutzer wurde gelöscht"
    Then I should not see "aba.dbuser@bvs.de"
