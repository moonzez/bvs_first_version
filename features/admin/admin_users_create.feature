Feature: Creating new users
  In order to manage users
  As an admin
  I want to be able to create new users

  Background:
    Given I am logged in as an admin
    And There is a role "dbuser"
    And There is a role "referent"
    And I am on the homepage
    Given I follow "Nutzer anlegen"

  Scenario: create not referent with valid data
    Then I should see title "BVS - Nutzer anlegen"
    When I choose ("user_gender_herr")
    And I fill in "Vorname" with "John"
    And I fill in "Nachname" with "Doe"
    And I fill in "Login" with "johndoe"
    And I fill in "Password" with "johndoe"
    And I fill in "Password wiederholen" with "johndoe"
    And I fill in "Email" with "john.doe@bvs.de"
    And I fill in "Telefon" with "6366437376"
    And I check ("role_dbuser")
    And I press "Speichern"
    Then I should see "Nutzer John Doe wurde angelegt"
    And I should see "john.doe@bvs.de"
    And I should see "dbuser"

  Scenario: create not referent with invalid data
    When I press "Speichern"
    Then I should see "Email entspricht nicht dem Format"
    And I should see "Email darf nicht leer sein"
    And I should see "Login ist zu kurz"
    And I should see "Login darf nur Buchstaben, Nummer und .-_@ enthalten"
    And I should see "Login darf nicht leer sein"
    And I should see "Password ist zu kurz"
    And I should see "Password wiederholen stimmt nicht mit Password überein"
    And I should see "Password wiederholen ist zu kurz"
    And I should see "Anrede darf nicht leer sein"
    And I should see "Nachname darf nicht leer sein"
    And I should see "Vorname darf nicht leer sein"
    And I should see "Telefon darf nicht leer sein"

  Scenario: create referent with invalid data
    When I choose ("user_gender_herr")
    And I fill in "Vorname" with "John"
    And I fill in "Nachname" with "Doe"
    And I fill in "Login" with "johndoe"
    And I fill in "Password" with "johndoe"
    And I fill in "Password wiederholen" with "johndoe"
    And I fill in "Email" with "john.doe@bvs.de"
    And I fill in "Telefon" with "6366437376"
    And I check ("role_referent")
    And I press "Speichern"
    Then I should not see "Nutzer John Doe wurde angelegt"
    And I should see "Bank für Referenten darf nicht leer sein"
    And I should see "IBAN für Referenten darf nicht leer sein"
    And I should see "BIC für Referenten darf nicht leer sein"

  Scenario: create referent with valid data
    When I choose ("user_gender_herr")
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
    And I check ("role_referent")
    And I press "Speichern"
    Then I should see "Nutzer John Doe wurde angelegt"
    And I should see "john.doe@bvs.de"
    And I should see "referent"
