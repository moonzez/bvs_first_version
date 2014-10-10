Feature: Editing users
  In order to manage users
  As an admin
  I want to be able to edit user data

  Background:
    Given There are the following users with role "dbuser":
      |firstname|lastname|email|tel|
      |Aba|Bduser|aba.dbuser@bvs.de|1234567|
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|
      |Deba|Referent|deba.referent@bvs.de|765432|
    Given I am logged in as an admin
    And I am on the homepage
    Given I follow "Nutzer"

  Scenario: edit user data with valid data
    Then I should see title "BVS - Alle Nutzer"
    When I follow image_link "Bearbeiten" for user "aba.dbuser@bvs.de"
    Then I should see title "BVS - Nutzer bearbeiten"
    And I should see "Nutzer bearbeiten"
    When I fill in "Nachname" with "Married"
    And I press "Speichern"
    Then I should see "Nutzerdaten für Aba Married wurden geändert"

  Scenario: edit user data with invalid data
    When I follow image_link "Bearbeiten" for user "aba.dbuser@bvs.de"
    And I should see "Nutzer bearbeiten"
    When I fill in "Nachname" with ""
    When I fill in "Vorname" with ""
    When I fill in "Login" with ""
    When I fill in "Email" with ""
    When I fill in "Telefon" with ""
    And I press "Speichern"
    And I should not see "wurden geändert"
    And I should see "Nachname darf nicht leer sein"
    And I should see "Vorname darf nicht leer sein"
    And I should see "Login darf nicht leer sein"
    And I should see "Email darf nicht leer sein"
    And I should see "Telefon darf nicht leer sein"

  Scenario: deleting bank data for referent
    When I follow image_link "Bearbeiten" for user "deba.referent@bvs.de"
    And I should see "Nutzer bearbeiten"
    When I fill in "Bank" with ""
    When I fill in "IBAN" with ""
    When I fill in "BIC" with ""
    And I press "Speichern"
    Then I should not see "Nutzerdaten für Deba Referent wurden geändert"
    And I should see "Bank für Referenten darf nicht leer sein"
    And I should see "IBAN für Referenten darf nicht leer sein"
    And I should see "BIC für Referenten darf nicht leer sein"

  Scenario: checking licenses for referent
    Given There is a license "This is a new license A" "License A"
    When I follow image_link "Bearbeiten" for user "deba.referent@bvs.de"
    And I check license "License A"
    And I press "Speichern"
    Then I should see "Nutzerdaten für Deba Referent wurden geändert"
    When I follow "Referenten"
    And I follow "R"
    Then I should see "deba.referent@bvs.de"
    And I should see "License A"
