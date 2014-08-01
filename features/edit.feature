Feature: taskmeister opens vim to edit your task list

  Scenario: Edit entire task list
    Given a file named "mylist.md" with:
      """
# Task one [∞](#a8fd82de-c379-496d-a77b-2873192e8ea8)

Notes line one
Notes line two

# Task two [∞](#ae0cce15-456d-48c0-a2e2-69d5f567e092)

# Task three [∞](#a5d4d3a9-2b9a-427a-9047-b47c6aec8f93)
      """
    And I double `vim`
    When I run `taskmeister --list mylist.md --edit`
    Then the double `vim` should have been run with file "mylist.md"
    And the exit status should be 0

  Scenario: Edit specific task in the list
    Given a file named "mylist.md" with:
      """
# Task one [∞](#a8fd82de-c379-496d-a77b-2873192e8ea8)

Notes line one
Notes line two

# Task two [∞](#ae0cce15-456d-48c0-a2e2-69d5f567e092)

# Task three [∞](#a5d4d3a9-2b9a-427a-9047-b47c6aec8f93)
      """
    And I double `vim`
    When I run `taskmeister --list mylist.md --edit a`
    Then the double `vim` should have been run with "+/a8fd82de-c379-496d-a77b-2873192e8ea8" and file "mylist.md"
    And the exit status should be 0

