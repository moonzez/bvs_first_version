Feature: Viewing all referents
  In order to manage referents
  As an admin, dbuser or accounter
  I want to see the list of all referents

  Background:
    Given There are the following users with role "dbuser":
      |firstname|lastname|email|tel|activ|
      |Aba|Dbuser|aba.dbuser@bvs.de|1234567|activ|
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|activ|
      |Deba|Meba|deba.meba@bvs.de|765432|activ|
      |John |Doe|john.doe@bvs.de|55555555|temporary|
      |Some|Person|some.person@bvs.de|444444|inactiv|
    Given I am logged in as an admin
    And I am on the homepage
    Given I follow "Referenten"

  Scenario: see the list of activ or temporary referents
    Then I should see title "BVS - Alle Referenten"
    Then I should see "Meba"
    And I should see "Deba"
    And I should see "765432"
    And I should see "deba.meba@bvs.de"
    And I should see image_link "Temporär deaktivieren" for referent "deba.meba@bvs.de"
    And I should see image_link "Deaktivieren" for referent "deba.meba@bvs.de"
    And I should see image_link "Bearbeiten" for referent "deba.meba@bvs.de"
    And I should see image_link "Löschen" for referent "deba.meba@bvs.de"

    And I should see "Doe"
    And I should see "John"
    And I should see "55555555"
    And I should see "john.doe@bvs.d"
    And I should see image_link "Aktivieren" for referent "john.doe@bvs.de"
    And I should see image_link "Deaktivieren" for referent "john.doe@bvs.de"
    And I should see image_link "Bearbeiten" for referent "john.doe@bvs.de"
    And I should see image_link "Löschen" for referent "john.doe@bvs.de"

  Scenario: not see the other user roles in the list
    Then I should not see "Dbuser"
    And I should not see "Aba"
    And I should not see "aba.dbuser@bvs.de"
    And I should not see "1234567"
    And I should not see image_link "Bearbeiten" for referent "aba.dbuser@bvs.de"
    And I should not see image_link "Löschen" for referent "aba.dbuser@bvs.de"

  Scenario: see only users with selected letter
    When I follow "M"
    Then I should see "Meba"
    And I should see "Deba"
    And I should see "765432"
    And I should see "deba.meba@bvs.de"
    And I should see image_link "Bearbeiten" for referent "deba.meba@bvs.de"
    And I should see image_link "Löschen" for referent "deba.meba@bvs.de"

    And I should not see "Doe"
    And I should not see "John"
    And I should not see "55555555"
    And I should not see "john.doe@bvs.d"
    And I should not see image_link "Bearbeiten" for referent "john.doe@bvs.de"
    And I should not see image_link "Löschen" for referent "john.doe@bvs.de"

  Scenario: see all activ and temporary referents with selected *
    When I follow "*"
    Then I should see "Meba"
    And I should see "Deba"
    And I should see "765432"
    And I should see "deba.meba@bvs.de"
    And I should see image_link "Temporär deaktivieren" for referent "deba.meba@bvs.de"
    And I should see image_link "Deaktivieren" for referent "deba.meba@bvs.de"
    And I should see image_link "Bearbeiten" for referent "deba.meba@bvs.de"
    And I should see image_link "Löschen" for referent "deba.meba@bvs.de"

    And I should see "Doe"
    And I should see "John"
    And I should see "55555555"
    And I should see "john.doe@bvs.d"
    And I should see image_link "Aktivieren" for referent "john.doe@bvs.de"
    And I should see image_link "Deaktivieren" for referent "john.doe@bvs.de"
    And I should see image_link "Bearbeiten" for referent "john.doe@bvs.de"
    And I should see image_link "Löschen" for referent "john.doe@bvs.de"

  Scenario: not see inactiv referents
    And I should not see "Some"
    And I should not see "Person"
    And I should not see "444444"
    And I should not see "some.person@bvs.de"
