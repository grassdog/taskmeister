Feature: taskmeister lists the contents of a task list

  Scenario: Normal directory with explicit task list
    Given a file named "mylist.md" with:
      """
Task one - [id](aaf83a9b-02f7-4cc0-8ee1-4d98b98903b8)

> Notes line one
> Notes line two

Task two - [id](ae0cce15-456d-48c0-a2e2-69d5f567e092)
Task three - [id](a5d4d3a9-2b9a-427a-9047-b47c6aec8f93)
      """
    When I successfully run `taskmeister --list mylist.md`
    Then the output should contain "a  - Task one »"
    And  the output should contain "ae - Task two"
    And  the output should contain "a5 - Task three"

