Feature: it should commit all files and directories to VCS

  Scenario Outline: committing the default structure
    When it commits all files and directories
    Then it there should be .gitkeep files in exactly the following directories of "<parent_path>/<project_directory>"
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
    And it should run git add on exactly the following paths in "<parent_path>/<project_directory>":
      | path                                            |
      | Gemfile                                         |
      | .gitignore                                      |
      | dirt/tests/behaviours/support/env.rb            |
      | config/.gitkeep                                 |
      | dirt/contexts/.gitkeep                          |
      | dirt/contexts/roles/.gitkeep                    |
      | dirt/models/.gitkeep                            |
      | dirt/tests/behaviours/.gitkeep                  |
      | dirt/tests/behaviours/support/.gitkeep          |
      | dirt/tests/behaviours/step_definitions/.gitkeep |
      | dirt/tests/isolations/.gitkeep                  |
      | faces/.gitkeep                                  |
    And it should run "git commit -am "Dirt Project Init""
    And it should run "git push"
  Examples:
    | parent_path           | project_directory |
    |                       | my_project        |
    | a_path/to/the project | my_project        |
    |                       | my_other_project  |
    | some/other/path       | my_other_project  |