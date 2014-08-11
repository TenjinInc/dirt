Feature: create files

  Scenario Outline: parent directories exist
    Given the following directories exist:
      | path                                          |
      | <project_path>/dirt/tests/behaviours/support/ |
    When it creates project files in "<project_path>"
    Then there should be file "<project_path>/dirt/<project_name>.rb" from template "template.project_name.rb"
    And there should be file "<project_path>/Gemfile" from template "template.gemfile.rb"
    And there should be file "<project_path>/.gitignore" from template "template.gitignore"
    And there should be file "<project_path>/dirt/tests/behaviours/support/env.rb" from template "template.env.rb"
  Examples:
    | project_name    | project_path              |
    | my_project      | my_project                |
    | another_project | somewhere/another_project |

  Scenario Outline: parent directories do not exist
    When it creates project files in "<project_path>"
    Then there should be file "<project_path>/dirt/<project_name>.rb" from template "template.project_name.rb"
    And there should be file "<project_path>/Gemfile" from template "template.gemfile.rb"
    And there should be file "<project_path>/.gitignore" from template "template.gitignore"
    And there should be file "<project_path>/dirt/tests/behaviours/support/env.rb" from template "template.env.rb"
  Examples:
    | project_name    | project_path              |
    | my_project      | my_project                |
    | another_project | somewhere/another_project |