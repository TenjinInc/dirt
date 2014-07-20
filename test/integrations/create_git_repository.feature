Feature: it should optionally create a git repository with the project in it

  Scenario Outline: it should create a central git repo on the given server
    When I run Samling with:
      | flag    | value               |
      | project | <project_directory> |
      | host    | localhost           |
      | user    | robin               |
    Then it should say "Initialized empty Git repository in /var/git/<project_directory>.git/"
    And there should be a central git repository on localhost in "/var/git/test/<project_directory>.git"
  Examples:
    | project_directory |
    | my_project        |
    | my_other_project  |

  Scenario Outline:it should pull the repository down
    When I run Samling with:
      | flag    | value               |
      | project | <project_directory> |
    Then it should say "Cloning into '/var/git/test/<project_directory>.git'..."
    And there should be a git repository in "<project_directory>"
  Examples:
    | project_directory |
    | my_project        |
    | my_other_project  |

  Scenario Outline: it should not run git when the --no-git flag is given
    When I run Samling with:
      | flag     | value               |
      | project  | <project_directory> |
      | --no-git |                     |
    Then it should say "Skipping git steps."
    And there should not be a git repository in "<project_directory>"
    And there should not be a central git repository in "/var/git/test/<project_directory>.git"
  Examples:
    | project_directory |
    | my_project        |
    | my_other_project  |

