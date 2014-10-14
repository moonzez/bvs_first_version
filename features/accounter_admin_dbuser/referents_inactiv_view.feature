Feature: Viewing inactiv referents
  In order to manage inactiv referents
  As an admin, dbuser or accounter
  I want to see the list of them

  Background:
    Given There are the following users with role "dbuser":
      |firstname|lastname|email|tel|activ|
      |Aba|Dbuser|aba.dbuser@bvs.de|1234567|activ|
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|activ|
      |Deba|Meba|deba.meba@bvs.de|765432|activ|
      |John |Doe|john.doe@bvs.de|55555555|temporary|
      |Some|Person|some.person@bvs.de|444444|inactiv|
      |Very|Important|very.important@bvs.de|666666|inactiv|
    Given I am logged in as an dbuser
    And I am on the homepage
    Given I follow "Deaktivierten Referenten"

  Scenario: see the list of inactiv referents
    Then I should see title "BVS - Deaktivierten Referenten"
    And I should see "Deaktivierten Referenten"
    And I should see "Some"
    And I should see "Person"
    And I should see "some.person@bvs.de"
    And I should see "444444"
    And I should see image_link "Aktivieren" for referent "some.person@bvs.de"
    And I should see image_link "Bearbeiten" for referent "some.person@bvs.de"
    And I should not see image_link "Löschen" for referent "some.person@bvs.de"

    And I should see "Very"
    And I should see "Important"
    And I should see "very.important@bvs.de"
    And I should see "666666"
    And I should see image_link "Aktivieren" for referent "some.person@bvs.de"
    And I should see image_link "Bearbeiten" for referent "some.person@bvs.de"
    And I should not see image_link "Löschen" for referent "very.important@bvs.de"

  Scenario: not see activ or temporary inactiv referents
    Then I should not see "Meba"
    And I should not see "Deba"
    And I should not see "deba.meba@bvs.de"
    And I should not see "765432"

    And I should not see "Doe"
    And I should not see "John"
    And I should not see "55555555"
    And I should not see "john.doe@bvs.d"

  Scenario: not see the other user roles in the list
    Then I should not see "Dbuser"
    And I should not see "Aba"
    And I should not see "aba.dbuser@bvs.de"
    And I should not see "1234567"
    And I should not see image_link "Aktivierent" for referent "aba.dbuser@bvs.de"
    And I should not see image_link "Bearbeiten" for referent "aba.dbuser@bvs.de"

  Scenario: see only users with selected letter
    When I follow "P"
    Then I should see "Some"
    And I should see "Person"
    And I should see "some.person@bvs.de"
    And I should see "444444"
    And I should see image_link "Aktivieren" for referent "some.person@bvs.de"
    And I should see image_link "Bearbeiten" for referent "some.person@bvs.de"
    And I should not see image_link "Löschen" for referent "some.person@bvs.de"
