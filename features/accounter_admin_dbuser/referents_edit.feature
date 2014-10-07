Feature: Editing referents
  In order to manage referents
  As an accounter, admin or dbuser
  I want to be able to edit referent data

  Background:
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|
      |Deba|Meba|deba.meba@bvs.de|765432|
    Given I am logged in as an dbuser
    And I am on the homepage
    Given I follow "Referenten"

  Scenario: edit referent data with valid data
    Then I should see title "BVS - Alle Referenten"
    When I follow image_link "Bearbeiten" for referent "deba.meba@bvs.de"
    Then I should see title "BVS - Referenten bearbeiten"
    And I should see "Referenten bearbeiten"
    When I fill in "Nachname" with "Married"
    And I press "Speichern"
    Then I should see "Referentendaten für Deba Married wurden geändert"
    And I should see "Alle Referenten"

  Scenario: edit referent data with invalid data
    When I follow image_link "Bearbeiten" for referent "deba.meba@bvs.de"
    And I should see "Referenten bearbeiten"
    When I fill in "Nachname" with ""
    When I fill in "Vorname" with ""
    When I fill in "Login" with ""
    When I fill in "Email" with ""
    When I fill in "Telefon" with ""
    And I press "Speichern"
    Then I should not see "wurden geändert"
    And I should see "Nachname darf nicht leer sein"
    And I should see "Vorname darf nicht leer sein"
    And I should see "Login darf nicht leer sein"
    And I should see "Email darf nicht leer sein"
    And I should see "Telefon darf nicht leer sein"

  Scenario: deleting bank data for referent
    When I follow image_link "Bearbeiten" for referent "deba.meba@bvs.de"
    And I should see "Referenten bearbeiten"
    When I fill in "Bank" with ""
    When I fill in "IBAN" with ""
    When I fill in "BIC" with ""
    And I press "Speichern"
    Then I should not see "Referentendaten für Deba Meba wurden geändert"
    And I should see "Bank für Referenten darf nicht leer sein"
    And I should see "IBAN für Referenten darf nicht leer sein"
    And I should see "BIC für Referenten darf nicht leer sein"
