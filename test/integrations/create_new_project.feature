Feature: it should create new projects

  Scenario Outline: it should create the project structure
    When I run Samling with:
      | flag     | value          |
      | project  | <project_name> |
      | location | <parent_path>  |
    Then it should say "Time to grow, little <project_name>..."
    And it should say "Created project structure in <parent_path>/<project_name>."
    And there should be the following files:
      | path                                                     |
      | <parent_path>/<project_name>/app/contexts/.gitkeep       |
      | <parent_path>/<project_name>/app/contexts/roles/.gitkeep |
      | <parent_path>/<project_name>/app/faces/.gitkeep          |
      | <parent_path>/<project_name>/app/models/.gitkeep         |
      | <parent_path>/<project_name>/config/.gitkeep             |
      | <parent_path>/<project_name>/test/behaviours/.gitkeep    |
      | <parent_path>/<project_name>/test/factories/.gitkeep     |
      | <parent_path>/<project_name>/test/integrations/.gitkeep  |
  Examples:
    | parent_path           | project_name  |
    |                       | test_project  |
    | a_path/to/the project | test_project  |
    |                       | other_project |
    | some/other/path       | other_project |

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