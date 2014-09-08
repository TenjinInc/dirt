Feature: it should commit all files and directories to VCS

  Scenario Outline: committing the default structure
    Given the default structure exists in "<project_directory>"
    When it commits all files and directories in "<project_directory>"
    Then it there should be .gitkeep files in exactly the following directories of "<project_directory>"
      | path                  |
      | config                |
      | dirt/contexts/roles   |
      | dirt/models           |
      | dirt/tests/isolations |
      | faces                 |
    And it should run git add on exactly the following files in "<project_directory>":
      | path                                            |
      | Gemfile                                         |
      | .gitignore                                      |
      | config/.gitkeep                                 |
      | dirt/<project_name>.rb                          |
      | dirt/contexts/roles/.gitkeep                    |
      | dirt/models/.gitkeep                            |
      | dirt/tests/behaviours/support/env.rb            |
      | dirt/tests/behaviours/step_definitions/given.rb |
      | dirt/tests/behaviours/step_definitions/when.rb  |
      | dirt/tests/behaviours/step_definitions/then.rb  |
      | dirt/tests/isolations/.gitkeep                  |
      | faces/.gitkeep                                  |
    And it should run "git --git-dir "<project_directory>/.git" --work-tree "<project_directory>" commit -am "Dirt project init""
    And it should run "git --git-dir "<project_directory>/.git" --work-tree "<project_directory>" push origin master"
  Examples:
    | project_directory                 | project_name     |
    | /a_path/to/the project/my_project | my_project       |
    | /some/other/path/my_other_project | my_other_project |
