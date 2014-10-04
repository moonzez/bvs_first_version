Feature: Viewing users
  In order to manage users
  As an admin
  I want to see the list of all users

  Background:
    Given There are the following users:
      |firstname|lastname|email|tel|
      |Aba|Baba|aba.baba@bvs.de|1234567|
      |Deba|Meba|deba.meba@bvs.de|765432|
    Given I am logged in as an admin
    And I am on the homepage
    Given I follow "Nutzer"

  Scenario: see the list of all users
    Then I should see title "BVS - Alle Nutzer"
    Then I should see "Aba"
    And I should see "Baba"
    And I should see "aba.baba@bvs.de"
    And I should see "1234567"
    And I should see "Deba"
    And I should see "Meba"
    And I should see "deba.meba@bvs.de"
    And I should see "765432"
    And I should see link_image "Bearbeiten" to "user" "aba.baba@bvs.de"
    And I should see link_image "Löschen" to "user" "deba.meba@bvs.de"

  Scenario: see only users with selected letter
    When I follow "B"
    Then I should see "Aba"
    And I should see "Baba"
    And I should see "aba.baba@bvs.de"
    And I should see "1234567"
    And I should see link_image "Bearbeiten" to "user" "aba.baba@bvs.de"
    And I should see link_image "Löschen" to "user" "aba.baba@bvs.de"
    And I should not see "Deba"
    And I should not see "Meba"
    And I should not see "deba.meba@bvs.de"
    And I should not see "765432"
    And I should not see link_image "Bearbeiten" to "user" "deba.meba@bvs.de"
    And I should not see link_image "Löschen" to "user" "deba.meba@bvs.de"

  Scenario: see all users with selected *
    When I follow "*"
    Then I should see "Aba"
    And I should see "Baba"
    And I should see "aba.baba@bvs.de"
    And I should see "1234567"
    And I should see "Deba"
    And I should see "Meba"
    And I should see "deba.meba@bvs.de"
    And I should see "765432"
    And I should see link_image "Bearbeiten" to "user" "aba.baba@bvs.de"
    And I should see link_image "Bearbeiten" to "user" "deba.meba@bvs.de"
    And I should see link_image "Löschen" to "user" "aba.baba@bvs.de"
    And I should see link_image "Löschen" to "user" "deba.meba@bvs.de"
