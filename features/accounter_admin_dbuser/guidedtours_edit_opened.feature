@javascript
Feature: edit guidedtour
  In order to edit guided tour
  As an accounter, admin or dbuser
  I want to be able to change some data via form

  Background:
    Given I am logged in as an dbuser
    And There is an opened guidedtour
    And I am on the homepage
    When I put mouseover "Rundgänge"
    When I follow "Offene Rundgänge"
    And I follow image_link "Bearbeiten" for this guidedtour

  Scenario: edit with valid params
    Then I should see title "Rundgang - Datenänderung"
    And I should see "Rundgang - Datenänderung"
    And I fill in "Vorname" with "John"
    And I fill in "Handynummer der Begleitperson" with "55555555"
    And I press "Speichern"
    Then I should see "Geführter Rundgang wurde geändert"
    When I follow "Offene Rundgänge"
    And I follow image_link "Bearbeiten" for this guidedtour
    Then I should see field with "John"
    Then I should see field with "55555555"

  Scenario: edit state
    Then I should see state "offen"
    When I select state "abgesagt" for "guidedtour"
    And I press "Speichern"
    Then I should see "Geführter Rundgang wurde geändert"
    # TODO: abgesagte Rundgänge
    #    When I put mouseover "Rundgänge"
    #    When I follow "Abgesagte Rundgänge"
    #    And I follow image_link "Bearbeiten" for this guidedtour
    #   Then I should see state "abgesagt"

  Scenario: set state to confirmed without confirmed date
    Then I should see state "offen"
    When I select state "bestätigt" for "guidedtour"
    Then I should see alert "Bevor Sie den Status auf 'bestätigt' setzen, geben Sie das Datum und die Uhrzeiten des bestätigten Termins ein!"

  Scenario: edit confirmed date
    When I follow image_link "guidedtour_take_date1"
    And I press "Speichern"
    Then I should see "Geführter Rundgang wurde geändert"
    When I put mouseover "Rundgänge"
    When I follow "Offene Rundgänge"
    And I follow image_link "Bearbeiten" for this guidedtour
    Then I should see for guidedtour field "date1" equals field "confirmed_date"
