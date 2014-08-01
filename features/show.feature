Feature: taskmeister shows the details of a task in the list

  Scenario: Show task in list
    Given a file named "mylist.md" with:
      """
# Task one [∞](#a8fd82de-c379-496d-a77b-2873192e8ea8)

Notes line one
Notes line two

# Task two [∞](#ae0cce15-456d-48c0-a2e2-69d5f567e092)

# Task three [∞](#a5d4d3a9-2b9a-427a-9047-b47c6aec8f93)
      """
    When I successfully run `taskmeister --list mylist.md --show a`
    Then the output should contain "# Task one [∞](#a8fd82de-c379-496d-a77b-2873192e8ea8)"
    And the output should contain "Notes line one"
    And the output should contain "Notes line two"

