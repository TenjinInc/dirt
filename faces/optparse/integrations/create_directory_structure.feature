Feature: it should create a new project's directory structure

  Scenario Outline: it should create the project structure
    When I run Samling with:
      | flag     | value          |
      | project  | <project_name> |
      | location | <parent_path>  |
    Then it should say "Time to grow, little <project_name>..."
    And it should say "Created project structure in <parent_path>/<project_directory>."
    And ls should show the following files in "<parent_path>/<project_directory>":
      | path                                   |
      | config                                 |
      | dirt/contexts                          |
      | dirt/contexts/roles                    |
      | dirt/models                            |
      | dirt/tests/behaviours                  |
      | dirt/tests/behaviours/support          |
      | dirt/tests/behaviours/step_definitions |
      | dirt/tests/isolations                  |
      | faces                                  |
  Examples:
    | parent_path           | project_directory | project_name  |
    |                       | test_project      | Test Project  |
    | a_path/to/the project | test_project      | Test Project  |
    |                       | other_project     | Other Project |
    | some/other/path       | other_project     | Other Project |

  Scenario: it should require a project name
    When I run Samling
    Then it should say "Usage: samling [options] arguments"

  # error cases, etc.
  # - the project directory, or some file inside, already exists. Overwrite?
  # - the project directory is unwritable (permissions, etc)









#  Scenario Outline: the project root directory exists
#    When I create a new project "<project_name>"
#    Then it should say "<project_name> already exists. Do you want to initialize a project in that directory?"
#  Examples:
#    | project_name  |
#    | test_project  |
#    | other_project |
#
#  Scenario Outline: the project root directory exists and is confirmed
#    When I create a new project "<project_name>" and confirm the create
#    Then it should say "Time to grow, litte <project_name>"
#    And it should say "Created directories."
#    And it should say "Created main git repository at <git_bare>"
#    And it should say "Pushed initial structure to <git_bare>."
#  Examples:
#    | project_name  |
#    | test_project  |
#    | other_project |