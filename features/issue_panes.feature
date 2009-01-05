Feature: What I'm doing now
  As a user with issues to work on
  I want to see a prioritized list of what to work on
  So I can work on the most important issue next

  Scenario: See a prioritized list of tasks to do now
    Given there are 5 next issues
    And I am logged in
    And I am on the stuff to do page

    Then I should see "What I'm doing now"
    And I should see a list of tasks called "doing-now"
    And I should see a row for 5 "doing-now" tasks
    And I should see the issue title in the row

  Scenario: See the a total progress below the What I'm doing now pane
    Given there are 5 next issues
    And I am logged in
    And I am on the stuff to do page

    Then I should see "Total Progress"
    And I should see a progress graph, "doing-now-total-progress", at 50%

  Scenario: See a prioritized list of recommended tasks
    Given there are 15 next issues
    And I am logged in
    And I am on the stuff to do page
    Then I should see "What's recommended to do next"
    And I should see a list of tasks called "recommended"
    And I should see a row for 10 "recommended" tasks

  Scenario: See the a total progress below the Whats Recommended to do next pane
    Given there are 15 next issues
    And I am logged in
    And I am on the stuff to do page

    Then I should see "Total Progress"
    And I should see a progress graph, "recommended-total-progress", at 50%

  Scenario: See a list of all assigned tasks
    Given there are 30 issues assigned to me
    And there are 5 next issues
    And there are 10 issues not assigned to me
    And I am logged in
    And I am on the stuff to do page
    Then I should see "What's available"
    And I should see a list of tasks called "available"
    And I should see a row for 30 "available" tasks

  Scenario: See the a total progress below the What's Available pane
    Given there are 30 issues assigned to me
    And I am logged in
    And I am on the stuff to do page

    Then I should see "Total Progress"
    And I should see a progress graph, "available-total-progress", at 0%
