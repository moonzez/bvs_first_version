@javascript
Feature: create guidedtour
  In order to manage guided tours
  As an accounter, admin or dbuser
  I want to be able to create a new guidedtour internal

  Background:
    Given I am logged in as an dbuser
    And I am on the homepage
    And I put mouseover "Rundgänge"
    When I follow "Rundgang anlegen"

  Scenario: create quidedtour with valid params
    Then I should see title "Geführten Rundgang anlegen"
    And I should see "Geführten Rundgang anlegen"
    When I choose "guidedtour_gender_mr"
    And I fill in "Vorname" with "John"
    And I fill in "Nachname" with "Doe"
    And I fill in "E-mail" with "john.doe@bvs.de"
    And I fill in "Name" with "Our School"
    And I fill in "Strasse/Hausnummer" with "Mainstreet/23"
    And I fill in "Ort" with "Bigcity"
    And I fill in "PLZ" with "12345"
    And I fill in "Land" with "Greenland"
    And I fill in datepicker "guidedtour_date1" with "tomorrow"
    And I fill in time "guidedtour_from1" with "first"
    And I fill in "Teilnehmeranzahl" with "12"
    And I fill in "Handynummer der Begleitperson" with "01234567"

    And I press "Speichern"
    Then I should see "Geführter Rundgang wurde angelegt"
