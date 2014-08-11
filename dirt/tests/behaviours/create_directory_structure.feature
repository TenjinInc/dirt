Feature: it should create the expected directory tree

  Scenario Outline: the project root directory does not exist
    When I create a new project "<project_name>" at "<parent_path>"
    Then there should be the following files:
      | path                                                          |
      | <parent_path>/<project_directory>/app/contexts/.gitkeep       |
      | <parent_path>/<project_directory>/app/contexts/roles/.gitkeep |
      | <parent_path>/<project_directory>/app/faces/.gitkeep          |
      | <parent_path>/<project_directory>/app/models/.gitkeep         |
      | <parent_path>/<project_directory>/config/.gitkeep             |
      | <parent_path>/<project_directory>/test/behaviours/.gitkeep    |
      | <parent_path>/<project_directory>/test/factories/.gitkeep     |
      | <parent_path>/<project_directory>/test/integrations/.gitkeep  |
  Examples:
    | parent_path           | project_directory | project_name     |
    |                       | my_project        | My Project       |
    | a_path/to/the project | my_project        | My Project       |
    |                       | my_other_project  | My Other Project |
    | some/other/path       | my_other_project  | My Other Project |

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