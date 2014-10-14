Feature: Viewing all referents
  In order to manage referents
  As an admin
  I want to see the list of all referents and link to delete them

  Background:
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|activ|
      |Deba|Meba|deba.meba@bvs.de|765432|activ|
      |John |Doe|john.doe@bvs.de|55555555|temporary|
      |Some|Person|some.person@bvs.de|444444|inactiv|
    Given I am logged in as an admin
    And I am on the homepage

  Scenario: see the list of activ or temporary referents and link to delte them
    Given I follow "Referenten"
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

  Scenario: see inactiv referents and link to delete them
    Given I follow "Deaktivierten Referenten"
    Then I should see "Some"
    And I should see "Person"
    And I should see "444444"
    And I should see "some.person@bvs.de"
    And I should see image_link "Aktivieren" for referent "some.person@bvs.de"
    And I should see image_link "Bearbeiten" for referent "some.person@bvs.de"
    And I should see image_link "Löschen" for referent "some.person@bvs.de"
