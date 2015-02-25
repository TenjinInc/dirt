Feature: it should create the expected directory tree

  Scenario Outline: the project root directory does not exist
    When I create a new project in "<full_project_path>"
    Then there should be exactly the following directories in "/<full_project_path>":
      | path                                   |
      | config                                 |
      | core                                   |
      | core/contexts                          |
      | core/contexts/roles                    |
      | core/models                            |
      | core/tests                             |
      | core/tests/behaviours                  |
      | core/tests/behaviours/support          |
      | core/tests/behaviours/step_definitions |
      | core/tests/isolations                  |
      | faces                                  |
  Examples:
    | full_project_path                |
    | my_project                       |
    | a_path/to/the project/my_project |
    | my_other_project                 |
    | some/other/path/my_other_project |

  Scenario Outline: parent directories exist
    Given the following directories exist:
      | path                                          |
      | <project_path>/core/tests/behaviours/support/ |
    When I create a new project in "<project_path>"
    Then there should be files for "<project_name>" from templates:
      | path                                                           | template                 |
      | <project_path>/core/<project_name>.rb                          | template.project_name.rb |
      | <project_path>/Gemfile                                         | template.Gemfile         |
      | <project_path>/.gitignore                                      | template.gitignore       |
      | <project_path>/core/tests/behaviours/support/env.rb            | template.env.rb          |
      | <project_path>/core/tests/behaviours/step_definitions/given.rb |                          |
      | <project_path>/core/tests/behaviours/step_definitions/when.rb  |                          |
      | <project_path>/core/tests/behaviours/step_definitions/then.rb  |                          |
  Examples:
    | project_path              | project_name    |
    | my_project                | my_project      |
    | somewhere/another_project | another_project |

  Scenario Outline: parent directories do not exist
    When I create a new project in "<project_path>"
    Then there should be files for "<project_name>" from templates:
      | path                                                | template                 |
      | <project_path>/core/<project_name>.rb               | template.project_name.rb |
      | <project_path>/Gemfile                              | template.Gemfile         |
      | <project_path>/.gitignore                           | template.gitignore       |
      | <project_path>/core/tests/behaviours/support/env.rb | template.env.rb          |
  Examples:
    | project_name    | project_path              |
    | my_project      | my_project                |
    | another_project | somewhere/another_project |