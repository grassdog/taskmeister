Feature: taskmeister infers the name of your task list from your current project directory

  Scenario: List tasks in list found from project directory
    Given a directory named "project"
    And a directory named "project/.git"
    And a directory named "project/child"
    And a file named "project.md" with:
      """
# Task one [∞](#a8fd82de-c379-496d-a77b-2873192e8ea8)

Notes line one
Notes line two

# Task two [∞](#ae0cce15-456d-48c0-a2e2-69d5f567e092)

# Task three [∞](#a5d4d3a9-2b9a-427a-9047-b47c6aec8f93)
      """
    And I cd to "project/child"
    When I successfully run `taskmeister --task-dir ../../`
    Then the output should contain "a  - Task one »"
    And  the output should contain "ae - Task two"
    And  the output should contain "a5 - Task three"

