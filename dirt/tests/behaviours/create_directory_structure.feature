Feature: it should create the expected directory tree

  Scenario Outline: the project root directory does not exist
    When I create a new project "<project_directory>" at "<parent_path>"
    Then there should be exactly the following directories in "<parent_path>/<project_directory>":
      | path                                   |
      | config                                 |
      | dirt                                   |
      | dirt/contexts                          |
      | dirt/contexts/roles                    |
      | dirt/models                            |
      | dirt/tests                             |
      | dirt/tests/behaviours                  |
      | dirt/tests/behaviours/support          |
      | dirt/tests/behaviours/step_definitions |
      | dirt/tests/isolations                  |
      | faces                                  |
  Examples:
    | parent_path           | project_directory |
    |                       | my_project        |
    | a_path/to/the project | my_project        |
    |                       | my_other_project  |
    | some/other/path       | my_other_project  |

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