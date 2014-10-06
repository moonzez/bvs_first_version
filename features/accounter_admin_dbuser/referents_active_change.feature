@javascript
Feature: Change referents activ status
  In order to activate/deactivate referents
  As accounter, admin or dbuser
  I want to be able to do it on button click

  Background:
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|activ|
      |Deba|Meba|deba.meba@bvs.de|765432|activ|
      |John |Doe|john.doe@bvs.de|55555555|temporary|
    Given I am logged in as an dbuser
    And I am on the homepage
    Given I follow "Referenten"

  Scenario: activate temporary inactive referent
    Then I should not see image_link "Temporär deaktivieren" for referent "john.doe@bvs.de"
    When I follow image_link "Aktivieren" for referent "john.doe@bvs.de"
    Then I should see alert "Referent John Doe wurde aktiviert"
    And I should see image_link "Temporär deaktivieren" for referent "john.doe@bvs.de"
    And I should see "john.doe@bvs.de"

  Scenario: temporary inactivate activ referent
    Then I should not see image_link "Aktivieren" for referent "deba.meba@bvs.de"
    When I follow image_link "Temporär deaktivieren" for referent "deba.meba@bvs.de"
    Then I should see alert "Referent Deba Meba wurde temporär deaktiviert"
    And I should see image_link "Aktivieren" for referent "deba.meba@bvs.de"
    And I should see "deba.meba@bvs.de"

  Scenario: deactivate active referent
    When I follow image_link "Deaktivieren" for referent "deba.meba@bvs.de"
    Then I should see alert "Referent Deba Meba wurde deaktiviert"
    And I should not see "deba.meba@bvs.de"

  Scenario: deactivate temporary inactiv referent
    When I follow image_link "Deaktivieren" for referent "john.doe@bvs.de"
    Then I should see alert "Referent John Doe wurde deaktiviert"
    And I should not see "john.doe@bvs.de"
