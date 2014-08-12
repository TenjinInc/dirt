Feature: create files

  Scenario Outline: parent directories exist
    Given the following directories exist:
      | path                                          |
      | <project_path>/dirt/tests/behaviours/support/ |
    When it creates project files in "<project_path>"
    Then there should be files for "<project_name>" from templates:
      | path                                                | template                 |
      | <project_path>/dirt/<project_name>.rb               | template.project_name.rb |
      | <project_path>/Gemfile                              | template.Gemfile         |
      | <project_path>/.gitignore                           | template.gitignore       |
      | <project_path>/dirt/tests/behaviours/support/env.rb | template.env.rb          |
  Examples:
    | project_name    | project_path              |
    | my_project      | my_project                |
    | another_project | somewhere/another_project |

  Scenario Outline: parent directories do not exist
    When it creates project files in "<project_path>"
    Then there should be files for "<project_name>" from templates:
      | path                                                | template                 |
      | <project_path>/dirt/<project_name>.rb               | template.project_name.rb |
      | <project_path>/Gemfile                              | template.Gemfile         |
      | <project_path>/.gitignore                           | template.gitignore       |
      | <project_path>/dirt/tests/behaviours/support/env.rb | template.env.rb          |
  Examples:
    | project_name    | project_path              |
    | my_project      | my_project                |
    | another_project | somewhere/another_project |