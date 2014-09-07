Feature: create default face

  Scenario Outline: the project root directory does not exist
    When I create a new basic face "<face_name>" at "<project_root>"
    Then there should be exactly the following directories in "<project_root>/faces/<face_name>":
      | path                          |
      | integrations                  |
      | integrations/support          |
      | integrations/step_definitions |
  Examples:
    | project_root           | face_name     |
    |                        | my_face       |
    | /a_path/to/the project | my_face       |
    |                        | my_other_face |
    | /some/other/path       | my_other_face |

  Scenario Outline: parent directories exist
    Given the following directories exist:
      | path                                                                 |
      | <project_path>/dirt/faces/<face_name>/integrations/support/          |
      | <project_path>/dirt/faces/<face_name>/integrations/step_definitions/ |
    When I create a new basic face "<face_name>" at "<project_path>"
    Then there should be files for "<project_name>" from templates:
      | path                                                                     | template        |
      | /<project_path>/faces/<face_name>/integrations/support/env.rb            | template.env.rb |
      | /<project_path>/faces/<face_name>/integrations/step_definitions/given.rb |                 |
      | /<project_path>/faces/<face_name>/integrations/step_definitions/when.rb  |                 |
      | /<project_path>/faces/<face_name>/integrations/step_definitions/then.rb  |                 |
  Examples:
    | project_name    | project_path              | face_name |
    | my_project      | my_project                | web       |
    | another_project | somewhere/another_project | web       |
    | my_project      | my_project                | cli       |
    | another_project | somewhere/another_project | cli       |

  Scenario Outline: parent directories do not exist
    When I create a new basic face "<face_name>" at "<project_path>"
    Then there should be files for "<project_name>" from templates:
      | path                                                                    | template        |
      | <project_path>/faces/<face_name>/integrations/support/env.rb            | template.env.rb |
      | <project_path>/faces/<face_name>/integrations/step_definitions/given.rb |                 |
      | <project_path>/faces/<face_name>/integrations/step_definitions/when.rb  |                 |
      | <project_path>/faces/<face_name>/integrations/step_definitions/then.rb  |                 |
  Examples:
    | project_name    | project_path              | face_name |
    | my_project      | my_project                | web       |
    | another_project | somewhere/another_project | web       |
    | my_project      | my_project                | cli       |
    | another_project | somewhere/another_project | cli       |