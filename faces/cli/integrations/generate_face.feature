Feature: it should create new face with its default contents
  # === Happy cases ====
  Scenario Outline: dirt generate face MEDIUM
    Given this feature is unimplemented
  Examples:
    | nope |

  Scenario Outline: dirt generate face MEDIUM/ENGINE
    Given this feature is unimplemented
  Examples:
    | nope |

  # === Unhappy cases ====
  # dirt generate project --name test --face
  Scenario: Generate project with name and face but no face arg
    Given this feature is unimplemented

  # dirt generate face no_medium
  Scenario: Generate face but medium does not exist
    Given this feature is unimplemented

  # dirt generate face medium/no_engine
  Scenario: Generate face but engine does not exist
    Given this feature is unimplemented

#  Scenario Outline: Running with just project flag
#    Given I am in "<parent_path>"
#    When I run dirt generate with:
#      | flag    | value          |
#      | project | <project_name> |
#    Then it should say "Time to grow, little <project_name>..."
#    And it should say "Created project structure in <parent_path>/<project_directory>."
#    And ls should show the following files in "<parent_path>/<project_directory>":
#      | path                                   |
#      | config                                 |
#      | dirt/contexts                          |
#      | dirt/contexts/roles                    |
#      | dirt/models                            |
#      | dirt/tests/behaviours                  |
#      | dirt/tests/behaviours/support          |
#      | dirt/tests/behaviours/step_definitions |
#      | dirt/tests/isolations                  |
#      | faces                                  |
#  Examples:
#    | parent_path           | project_directory | project_name     |
#    |                       | my_project        | My Project       |
#    | a_path/to/the project | my_project        | My Project       |
#    |                       | my_other_project  | My Other Project |
#    | some/other/path       | my_other_project  | My Other Project |
#
#  Scenario: it should require a project name
#    When I run dirt generate with no args
#    Then it should say "Usage: samling [options] arguments"