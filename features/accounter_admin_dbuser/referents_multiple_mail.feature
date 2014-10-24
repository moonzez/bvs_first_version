@javascript
Feature: Mailing to referents list
  In order to mailto to multiple referents
  As an dbuser or accounter
  I want to do it on referents view site

  Background:
    Given There are the following users with role "referent":
      |firstname|lastname|email|tel|
      |Deba|Meba|deba.meba@bvs.de|765432|
      |John |Doe|john.doe@bvs.de|55555555|
      |Some|Person|some.person@bvs.de|444444|
    Given I am logged in as an dbuser
    And I am on the homepage
    Given I follow "Referenten"

  Scenario: see not checked checkboxes for all referents
    Then I should see title "Alle Referenten"
    And I should see unchecked mailto_box for referent "deba.meba@bvs.de"
    And I should see unchecked mailto_box for referent "john.doe@bvs.de"
    And I should see unchecked mailto_box for referent "some.person@bvs.de"

  Scenario: see all checkboxes selected when checking 'an alle'
    When I check mailto_box for all
    Then I should see checked mailto_box for referent "deba.meba@bvs.de"
    And  I should see checked mailto_box for referent "john.doe@bvs.de"
    And I should see checked mailto_box for referent "some.person@bvs.de"

  Scenario: see all checkboxes unselected when unchecking 'an alle'
    When I check mailto_box for referent "deba.meba@bvs.de"
    And I check mailto_box for referent "john.doe@bvs.de"
    Then I should see checked mailto_box for referent "deba.meba@bvs.de"
    And  I should see checked mailto_box for referent "john.doe@bvs.de"
    And I should see unchecked mailto_box for referent "some.person@bvs.de"
    When I check mailto_box for all
    When I uncheck mailto_box for all
    And I should see unchecked mailto_box for referent "deba.meba@bvs.de"
    And I should see unchecked mailto_box for referent "john.doe@bvs.de"
    And I should see unchecked mailto_box for referent "some.person@bvs.de"
