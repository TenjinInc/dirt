Feature: it should create new projects

  Scenario Outline: it should create the project structure
    When I run Samling with:
      | flag     | value          |
      | project  | <project_name> |
      | location | <parent_path>  |
    Then it should say "Time to grow, little <project_name>..."
    And it should say "Created project structure in <parent_path>/<project_directory>."
    And there should be the following files:
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
    | parent_path           | project_directory | project_name  |
    |                       | test_project      | Test Project  |
    | a_path/to/the project | test_project      | Test Project  |
    |                       | other_project     | Other Project |
    | some/other/path       | other_project     | Other Project |

  Scenario: it should require a project name
    When I run Samling
    Then it should say "I need the project name. Please supply --project-name argument."

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