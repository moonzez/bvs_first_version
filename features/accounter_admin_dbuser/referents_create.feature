Feature: Creating new referents
  In order to manage referent
  As an dbuser, admin or accoutant
  I want to be able to create new users

  Background:
    Given I am logged in as an dbuser
    And There is a role "referent"
    And There is a language "Deutsch"
    And There is a language "English"
    And There is a language "Italienisch"
    And There is a license "This is a new license A" "License A"
    And There is a license "This is a new license B" "License B"
    And I am on the homepage
    And I follow "Referenten anlegen"

  Scenario: create referent with invalid data
    Then I should see title "BVS - Referenten anlegen"
    When I choose ("referent_gender_herr")
    And I fill in "Vorname" with "John"
    And I fill in "Nachname" with "Doe"
    And I fill in "Login" with "johndoe"
    And I fill in "Password" with "johndoe"
    And I fill in "Password wiederholen" with "johndoe"
    And I fill in "Email" with "john.doe@bvs.de"
    And I fill in "Telefon" with "6366437376"
    And I press "Speichern"
    Then I should not see "Nutzer John Doe wurde angelegt"
    And I should see "Bank für Referenten darf nicht leer sein"
    And I should see "IBAN für Referenten darf nicht leer sein"
    And I should see "BIC für Referenten darf nicht leer sein"

  Scenario: create referent with valid data
    When I choose ("referent_gender_herr")
    And I fill in "Vorname" with "John"
    And I fill in "Nachname" with "Doe"
    And I fill in "Login" with "johndoe"
    And I fill in "Password" with "johndoe"
    And I fill in "Password wiederholen" with "johndoe"
    And I fill in "Email" with "john.doe@bvs.de"
    And I fill in "Telefon" with "6366437376"
    And I fill in "Bank" with "Some bank"
    And I fill in "IBAN" with "SOMEIBAN"
    And I fill in "BIC" with "982429348293"
    And I check language "Deutsch"
    And I check language "Italienisch"
    And I check license "License A"
    And I press "Speichern"
    Then I should see "Referent John Doe wurde angelegt"
    And I should see "john.doe@bvs.de"
    And I should see "Deutsch"
    And I should see "Italienisch"
    And I should not see "Englisch"
    And I should see "License A"
    And I should not see "License B"
