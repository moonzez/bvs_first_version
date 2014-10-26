Feature:
  In order to give different kinds of user different functionality
  As a user
  I want to be able to see the in navigation

  Scenario: Navi for admin
    Given I am logged in as an admin
    And I am on the homepage
    Then I should see "Home" link
    And I should see "Nutzer" link
    And I should see "Nutzer anlegen" link

    And I should see "Rundgänge" link
    And I should see "Offene Rundgänge" link
    And I should see "Rundgang anlegen" link

    And I should see "Referenten" link
    And I should see "Referenten anlegen" link
    And I should see "Lizenzen" link
    And I should see "Sprachen" link
    And I should see "Deaktivierten Referenten" link

    And I should see "Abmelden" link
    And I should see "Profil ändern" link

  Scenario: Navi for dbuser
    Given I am logged in as an dbuser
    And I am on the homepage
    Then I should see "Home" link

    And I should see "Rundgänge" link
    And I should see "Offene Rundgänge" link
    And I should see "Rundgang anlegen" link

    And I should see "Referenten" link
    And I should see "Referenten anlegen" link
    And I should see "Lizenzen" link
    And I should see "Sprachen" link
    And I should see "Deaktivierten Referenten" link

    And I should see "Abmelden" link
    And I should see "Profil ändern" link

    And I should not see "Nutzer" link
    And I should not see "Nutzer anlegen" link

  Scenario: Navi for referent
    Given I am logged in as an referent
    And I am on the homepage
    Then I should see "Home" link
    And I should see "Abmelden" link
    And I should see "Profil ändern" link

    And I should not see "Rundgänge" link
    And I should not see "Offene Rundgänge" link
    And I should not see "Rundgang anlegen" link

    And I should not see "Nutzer" link
    And I should not see "Nutzer anlegen" link
    And I should not see "Referenten" link
    And I should not see "Referenten anlegen" link
    And I should not see "Lizenzen" link
    And I should not see "Sprachen" link
    And I should not see "Deaktivierten Referenten" link

  Scenario: Navi for accounter
    Given I am logged in as an accounter
    And I am on the homepage
    Then I should see "Home" link

    And I should see "Rundgänge" link
    And I should see "Offene Rundgänge" link
    And I should see "Rundgang anlegen" link

    And I should see "Referenten" link
    And I should see "Referenten anlegen" link
    And I should see "Lizenzen" link
    And I should see "Sprachen" link
    And I should see "Deaktivierten Referenten" link

    And I should see "Abmelden" link
    And I should see "Profil ändern" link

    And I should not see "Nutzer" link
    And I should not see "Nutzer anlegen" link

  Scenario: Navi for reader
    Given I am logged in as an reader
    And I am on the homepage
    Then I should see "Home" link
    And I should see "Abmelden" link
    And I should see "Profil ändern" link

    And I should not see "Rundgänge" link
    And I should not see "Offene Rundgänge" link
    And I should not see "Rundgang anlegen" link

    And I should not see "Nutzer" link
    And I should not see "Nutzer anlegen" link
    And I should not see "Referenten" link
    And I should not see "Referenten anlegen" link
    And I should not see "Lizenzen" link
    And I should not see "Sprachen" link
    And I should not see "Deaktivierten Referenten" link
