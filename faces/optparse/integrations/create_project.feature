Feature: it should create new project with its default contents and an accompanying git repo
  # Usage: dirt project [--project-name NAME] [--face MEDIUM[/ENGINE]]

  # Usage: dirt project NAME
  # Usage: dirt face MEDIUM[/ENGINE]
  # Usage: dirt context NAME
  # Usage: dirt model NAME
  # Usage: dirt role NAME


  # Usage: dirt generate [--project NAME] [--face MEDIUM[/ENGINE]] [--context NAME] [--model NAME] [--role NAME]


  # Some examples:
  # dirt generate -p "My New Project"
  # dirt generate -p my_project --face web/sinatra
  # dirt generate --face web/sinatra my_project


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
    | parent_path           | project_directory | project_name     |
    |                       | my_project        | My Project       |
    | a_path/to/the project | my_project        | My Project       |
    |                       | my_other_project  | My Other Project |
    | some/other/path       | my_other_project  | My Other Project |

  Scenario: it should require a project name
    When I run Samling with no args
    Then it should say "Usage: samling [options] arguments"

  # error cases, etc.
  # - the project directory, or some file inside, already exists. Overwrite?
  # - the project directory is unwritable (permissions, etc)
