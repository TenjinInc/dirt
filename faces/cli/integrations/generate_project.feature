Feature: it should create new project with its default contents and an accompanying git repo

  # === Happy cases ====
  Scenario Outline: dirt generate project --name NAME
    Given this feature is unimplemented
  Examples:
    | nope |
    |      |

  Scenario Outline: dirt generate project --name NAME --face MEDIUM/ENGINE
    Given this feature is unimplemented
  Examples:
    | nope |
    |      |

  Scenario Outline: dirt generate project --name NAME --location PATH
    Given this feature is unimplemented
  Examples:
    | nope |
    |      |

  Scenario Outline: dirt generate project --name NAME --location PATH --face MEDIUM/ENGINE
    Given this feature is unimplemented
  Examples:
    | nope |
    |      |

  # === Unhappy cases ====
  # dirt generate project
  Scenario: Generate project without name or location
    Given this feature is unimplemented

  # dirt generate project --name
  Scenario: Generate project but missing name arg
    Given this feature is unimplemented

  # dirt generate project --name test --location
  Scenario: Generate project but missing location arg
    Given this feature is unimplemented

  # dirt generate project --location path
  Scenario: Generate project with location but no name
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