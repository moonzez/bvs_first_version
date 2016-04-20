Feature:
  In order to change my own data
  As a user
  I want to be able to edit my profile data

  Background:
    Given There is a license "This is a new license A" "License A"
    And There is a license "This is a new license B" "License B"
    And There is a language "Deutsch"
    And There is a language "Englisch"
    And There is a role "accounter"

  Scenario: edit profile as admin with valid data
    Given I am logged in as an admin
    And I am on the homepage
    When I follow "Profil"
    Then I should see title "Profil"
    And I should see "Profil bearbeiten"
    And I should not see "License A"
    And I should not see "License B"
    And I should not see "Deutsch"
    And I should not see "Englisch"
    And I should see "accounter"
    And I should see "admin"
    When I fill in "Nachname" with "Married"
    And I check role "accounter"
    And I press "Speichern"
    Then I should see "Ihr Profil wurde geändert"
    And I should see title "Home"
    When I follow "Nutzer"
    And I follow "M"
    Then I should see "Married"
    And I should see "admin"
    And I should see "accounter"

  Scenario: edit profile as admin with invalid data
    Given I am logged in as an admin
    And I am on the homepage
    When I follow "Profil"
    When I fill in "Email" with "invalid.mail"
    And I press "Speichern"
    Then I should not see "Ihr Profil wurde geändert"
    Then I should see "Email entspricht nicht dem Format"

  Scenario: edit profile as dbuser with valid data
    Given I am logged in as an dbuser
    And I am on the homepage
    When I follow "Profil"
    Then I should see title "Profil"
    And I should see "Profil bearbeiten"
    And I should not see "License A"
    And I should not see "License B"
    And I should not see "Deutsch"
    And I should not see "Englisch"
    And I should not see "dbuser"
    And I should not see "accounter"
    And I should not see "admin"
    When I fill in "Nachname" with "Married"
    And I press "Speichern"
    Then I should see "Ihr Profil wurde geändert"
    And I should see title "Home"
    When I follow "Profil"
    Then I should see field with "Married"

  Scenario: edit profile as dbuser with invalid data
    Given I am logged in as an dbuser
    And I am on the homepage
    When I follow "Profil"
    When I fill in "Nachname" with ""
    And I press "Speichern"
    Then I should not see "Ihr Profil wurde geändert"
    And I should see "Nachname darf nicht leer sein"

  Scenario: edit profile as referent with valid data
    Given I am logged in as an referent
    And I am on the homepage
    When I follow "Profil"
    Then I should see title "Profil"
    And I should see "Profil bearbeiten"
    And I should see "License A"
    And I should see "License B"
    And I should see "Deutsch"
    And I should see "Englisch"
    And I should not see "referent"
    And I should not see "accounter"
    And I should not see "admin"
    When I fill in "Nachname" with "Married"
    And I check language "Englisch"
    And I check license "License A"
    And I press "Speichern"
    Then I should see "Ihr Profil wurde geändert"
    And I should see title "Home"
    When I follow "Profil"
    Then I should see field with "Married"
    And I see checked language "Englisch"
    And I see unchecked language "Deutsch"
    And I see checked license "License A"
    And I see unchecked license "License B"

  Scenario: edit profile as referent with invalid data
    Given I am logged in as an referent
    And I am on the homepage
    When I follow "Profil"
    When I fill in "Bank" with ""
    When I fill in "IBAN" with ""
    And I press "Speichern"
    Then I should not see "Ihr Profil wurde geändert"
    And I should see "Bank für Referenten darf nicht leer sein"
    And I should see "IBAN für Referenten darf nicht leer sein"

  Scenario: edit profile as accounter with valid data
    Given I am logged in as an accounter
    And I am on the homepage
    When I follow "Profil"
    Then I should see title "Profil"
    And I should see "Profil bearbeiten"
    And I should not see "License A"
    And I should not see "License B"
    And I should not see "Deutsch"
    And I should not see "Englisch"
    And I should not see "dbuser"
    And I should not see "accounter"
    And I should not see "admin"
    When I fill in "Vorname" with "Alejandro"
    And I press "Speichern"
    Then I should see "Ihr Profil wurde geändert"
    And I should see title "Home"
    When I follow "Profil"
    Then I should see field with "Alejandro"

  Scenario: edit profile as accounter with invalid data
    Given I am logged in as an accounter
    And I am on the homepage
    When I follow "Profil"
    When I fill in "Telefon" with ""
    And I press "Speichern"
    Then I should not see "Ihr Profil wurde geändert"
    And I should see "Telefon darf nicht leer sein"

  Scenario: edit profile as reader with valid data
    Given I am logged in as an reader
    And I am on the homepage
    When I follow "Profil"
    Then I should see title "Profil"
    And I should see "Profil bearbeiten"
    And I should not see "License A"
    And I should not see "License B"
    And I should not see "Deutsch"
    And I should not see "Englisch"
    And I should not see "dbuser"
    And I should not see "accounter"
    And I should not see "admin"
    When I fill in "Email" with "new.name@bvs.de"
    And I press "Speichern"
    Then I should see "Ihr Profil wurde geändert"
    And I should see title "Home"
    When I follow "Profil"
    Then I should see field with "new.name@bvs.de"

  Scenario: edit profile as reader with invalid data
    Given I am logged in as an reader
    And I am on the homepage
    When I follow "Profil"
    When I fill in "Email" with ""
    And I press "Speichern"
    Then I should not see "Ihr Profil wurde geändert"
    And I should see "Email darf nicht leer sein"
