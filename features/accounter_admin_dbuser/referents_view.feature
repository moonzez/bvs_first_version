Feature: Viewing all referents
  In order to manage referents
  As an admin, dbuser or accounter
  I want to see the list of all referents

  Background:
    Given There are the following users with role "dbuser":
      |firstname|lastname|email|tel|
      |Aba|Dbuser|aba.dbuser@bvs.de|1234567|
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|
      |Deba|Meba|deba.meba@bvs.de|765432|
      |John |Doe|john.doe@bvs.de|55555555|
    Given I am logged in as an admin
    And I am on the homepage
    Given I follow "Referenten"

  Scenario: see the list of all referents
    Then I should see title "BVS - Alle Referenten"
    Then I should see "Meba"
    And I should see "Deba"
    And I should see "765432"
    And I should see "deba.meba@bvs.de"
    And I should see link_image "Bearbeiten" to "referent" "deba.meba@bvs.de"
    And I should see link_image "Löschen" to "referent" "deba.meba@bvs.de"

    And I should see "Doe"
    And I should see "John"
    And I should see "55555555"
    And I should see "john.doe@bvs.d"
    And I should see link_image "Bearbeiten" to "referent" "john.doe@bvs.de"
    And I should see link_image "Löschen" to "referent" "john.doe@bvs.de"

  Scenario: not see the other user roles in the list
    Then I should not see "Dbuser"
    And I should not see "Aba"
    And I should not see "aba.dbuser@bvs.de"
    And I should not see "1234567"
    And I should not see link_image "Bearbeiten" to "referent" "aba.dbuser@bvs.de"
    And I should not see link_image "Löschen" to "referent" "aba.dbuser@bvs.de"

  Scenario: see only users with selected letter
    When I follow "M"
    Then I should see "Meba"
    And I should see "Deba"
    And I should see "765432"
    And I should see "deba.meba@bvs.de"
    And I should see link_image "Bearbeiten" to "referent" "deba.meba@bvs.de"
    And I should see link_image "Löschen" to "referent" "deba.meba@bvs.de"

    And I should not see "Doe"
    And I should not see "John"
    And I should not see "55555555"
    And I should not see "john.doe@bvs.d"
    And I should not see link_image "Bearbeiten" to "referent" "john.doe@bvs.de"
    And I should not see link_image "Löschen" to "referent" "john.doe@bvs.de"

  Scenario: see all users with selected *
    When I follow "*"
    Then I should see "Meba"
    And I should see "Deba"
    And I should see "765432"
    And I should see "deba.meba@bvs.de"
    And I should see link_image "Bearbeiten" to "referent" "deba.meba@bvs.de"
    And I should see link_image "Löschen" to "referent" "deba.meba@bvs.de"

    And I should see "Doe"
    And I should see "John"
    And I should see "55555555"
    And I should see "john.doe@bvs.d"
    And I should see link_image "Bearbeiten" to "referent" "john.doe@bvs.de"
    And I should see link_image "Löschen" to "referent" "john.doe@bvs.de"
