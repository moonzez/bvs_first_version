Feature: Create new license
  In order to add new referent licenses
  As an accounter, admin or dbuser
  I want to do it via button click

  Background:
    Given There is a license "This is a new license A" "License A"
    And There is a license "This is a new license B" "License B"
    And I am logged in as an dbuser
    And I am on the homepage
    And I follow "Lizenzen"

  Scenario: create new license
    When I fill in "Lizenztitel" with "This is a new license C"
    And I fill in "Abkürzung" with "License C"
    And I press "Speichern"
    And I should see "License C wurde angelegt"
    And I should see "This is a new license C"

  Scenario: trying to create existent Lizenz
    When I fill in "Lizenztitel" with "This is a new license B"
    And I fill in "Abkürzung" with "License A"
    And I press "Speichern"
    And I should see "Lizenz wurde nicht angelegt"
    And I should see "Lizenztitel ist bereits verwendet; Abkürzung ist bereits verwendet"
