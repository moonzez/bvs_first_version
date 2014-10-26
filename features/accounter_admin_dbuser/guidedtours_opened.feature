Feature: see othe list of opened guidedtours
  In order to manage new guided tours
  As an accounter, admin or dbuser
  I want to be able to see the list of all opened guidedtours

  Background:
    Given I am logged in as an dbuser
    And I am on the homepage
    And There are guidedtours:
      |created_at|lastname|date1|date2|date3|language|themetour|schoolname|city|participants|topic|film|
      |Time.now|Doe|Date.today + 4|Date.today + 5|Date.today + 6|en|0|Myschoolname|Mycity|12||0|
      |Time.now - 2|First|Date.today + 10|||de|1|Firstschool|Bigcity|40|Very important topic|1|
    When I follow "Offene Rundgänge"

  Scenario: see the list of all opened quidedtours
    Then I should see title "Offene Rundgänge"
    And I should see "Offene Rundgänge"

    And I should see "Eingangsdatum"
    And I should see date "Time.now"
    And I should see date "Time.now"

    And I should see "Kontaktperson"
    And I should see "Doe"
    And I should see "First"

    And I should see "Angefragter Termin"
    And I should see date "Date.today + 4"
    And I should see date "Date.today + 10"

    And I should see "Alternative Termine"
    And I should see "ja"
    And I should see "nein"

    And I should see "Sprache/ Thema TE"
    And I should see "Englisch"
    And I should see "Very important topic"

    And I should see "Schule/ Institution"
    And I should see "Myschool"
    And I should see "Firstschool"

    And I should see "Ort"
    And I should see "Mycity"
    And I should see "Bigcity"

    And I should see "TN"
    And I should see "12"
    And I should see "40"

    And I should see "Film"
    And I should see "Ja"
    And I should see "Nein"
