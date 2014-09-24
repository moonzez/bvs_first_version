Feature:
  In order to give different kinds of user different functionality
  As a user
  I want to be able to see the in navigation

  Scenario: Navi for admin
    Given I am logged in as an admin
    And I am on the homepage
    Then I should see "Home"
    And I should see "Nutzer"
    And I should see "Nutzer anlegen"
    And I should see "Referenten"
    And I should see "Lizenzen"
    And I should see "Sprachen"
    And I should see "Abmelden"

  Scenario: Navi for dbuser
    Given I am logged in as an dbuser
    And I am on the homepage
    Then I should see "Home"
    And I should see "Referenten"
    And I should see "Lizenzen"
    And I should see "Sprachen"
    And I should see "Abmelden"

    And I should not see "Nutzer"
    And I should not see "Nutzer anlegen"

  Scenario: Navi for referent
    Given I am logged in as an referent
    And I am on the homepage
    Then I should see "Home"
    And I should see "Abmelden"

    And I should not see "Nutzer"
    And I should not see "Nutzer anlegen"
    And I should not see "Referenten"
    And I should not see "Lizenzen"
    And I should not see "Sprachen"

  Scenario: Navi for accounter
    Given I am logged in as an accounter
    And I am on the homepage
    Then I should see "Home"
    And I should see "Referenten"
    And I should see "Lizenzen"
    And I should see "Sprachen"
    And I should see "Abmelden"

    And I should not see "Nutzer"
    And I should not see "Nutzer anlegen"

  Scenario: Navi for reader
    Given I am logged in as an reader
    And I am on the homepage
    Then I should see "Home"
    And I should see "Abmelden"

    And I should not see "Nutzer"
    And I should not see "Nutzer anlegen"
    And I should not see "Referenten"
    And I should not see "Lizenzen"
    And I should not see "Sprachen"
