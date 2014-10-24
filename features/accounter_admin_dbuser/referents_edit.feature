Feature: Editing referents
  In order to manage referents
  As an accounter, admin or dbuser
  I want to be able to edit referent data

  Background:
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|
      |Deba|Meba|deba.meba@bvs.de|765432|
    And There is a license "This is a new license A" "License A"
    And There is a license "This is a new license B" "License B"
    And User "deba.meba@bvs.de" has licenses:
      |title|shortcut|
      |This is a new license A|License A|
    And I am logged in as an dbuser
    And I am on the homepage
    And I follow "Referenten"
    Then I should see title "Alle Referenten"
    When I follow image_link "Bearbeiten" for referent "deba.meba@bvs.de"
    Then I should see title "Referenten bearbeiten"
    And I should see "Referenten bearbeiten"

  Scenario: edit referent data with valid data
    When I fill in "Nachname" with "Married"
    And I press "Speichern"
    Then I should see "Referentendaten für Deba Married wurden geändert"
    And I should see "Alle Referenten"

  Scenario: edit referent data with invalid data
    When I fill in "Nachname" with ""
    And I fill in "Vorname" with ""
    And I fill in "Login" with ""
    And I fill in "Email" with ""
    And I fill in "Telefon" with ""
    And I press "Speichern"
    Then I should not see "wurden geändert"
    And I should see "Nachname darf nicht leer sein"
    And I should see "Vorname darf nicht leer sein"
    And I should see "Login darf nicht leer sein"
    And I should see "Email darf nicht leer sein"
    And I should see "Telefon darf nicht leer sein"

  Scenario: deleting bank data for referent
    When I fill in "Bank" with ""
    And I fill in "IBAN" with ""
    And I fill in "BIC" with ""
    And I press "Speichern"
    Then I should not see "Referentendaten für Deba Meba wurden geändert"
    And I should see "Bank für Referenten darf nicht leer sein"
    And I should see "IBAN für Referenten darf nicht leer sein"
    And I should see "BIC für Referenten darf nicht leer sein"

  Scenario: changing licenses for referent
    When I uncheck license "License A"
    And I check license "License B"
    And I press "Speichern"
    Then I should see "Referentendaten für Deba Meba wurden geändert"
    And I should see "License B"
    And I should not see "License A"
