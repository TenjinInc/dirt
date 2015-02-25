Feature: it should commit all files and directories to VCS

  Scenario Outline: committing the default structure
    Given the default structure exists in "<project_directory>"
    And the following files exist:
      | path                                      |
      | <project_directory>/.git/some_git_file    |
      | <project_directory>/.git/.hidden_git_file |
    When it commits all files and directories in "<project_directory>"
    Then there should be .gitkeep files in exactly the following directories of "<project_directory>"
      | path                  |
      | config                |
      | core/contexts/roles   |
      | core/models           |
      | core/tests/isolations |
      | faces                 |
    And it should run git add on exactly the following files in "<project_directory>":
      | path                                            |
      | Gemfile                                         |
      | .gitignore                                      |
      | config/.gitkeep                                 |
      | core/<project_name>.rb                          |
      | core/contexts/roles/.gitkeep                    |
      | core/models/.gitkeep                            |
      | core/tests/behaviours/support/env.rb            |
      | core/tests/behaviours/step_definitions/given.rb |
      | core/tests/behaviours/step_definitions/when.rb  |
      | core/tests/behaviours/step_definitions/then.rb  |
      | core/tests/isolations/.gitkeep                  |
      | faces/.gitkeep                                  |
    And it should run "git --git-dir "<project_directory>/.git" --work-tree "<project_directory>" commit -am "Project init with Dirt.""
    And it should run "git --git-dir "<project_directory>/.git" --work-tree "<project_directory>" push origin master"
  Examples:
    | project_directory                 | project_name     |
    | /a_path/to/the project/my_project | my_project       |
    | /some/other/path/my_other_project | my_other_project |
