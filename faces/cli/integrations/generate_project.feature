Feature: it should create new project with its default contents and an accompanying git repo

  # === Happy cases ====
  # dirt generate project --name NAME
  Scenario Outline: generate project with just name, assume location is CWD
    Given I am in "<parent path>"
    When I generate a project with:
      | flag      | value        |
      | name      | <given name> |
      | bare-path | <bare path>  |
    Then it should say "Time to grow, little <displayed name>..."
    And it should have called "git init --bare <bare path>/<project directory>.git"
    And it should say "Initialized empty Git repository in <bare path>/<project directory>.git/"
    And it should say "Cloning into '<parent path>/<project directory>'..."
    And it should say "Created project structure in <parent path>/<project directory>."
    And ls should show the following files in "<parent path>/<project directory>":
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
    And it should say "Comitting..."
    And it should say "Dirt project init"
    And it should say "Pushed"
    And it should have called "git push origin master"
  Examples:
    | given name       | displayed name   | parent path            | project directory | bare path       |
    | my project       | My Project       | /a_path/to/the project | my_project        | some/git        |
    | my other project | My Other Project | /some/other/path       | my_other_project  | different/bares |

  Scenario Outline: dirt generate project --name NAME --location PATH
    Given I am in "/"
    When I generate a project with:
      | flag      | value         |
      | name      | my project    |
      | bare-path | some/git      |
      | location  | <parent path> |
    Then it should say "Time to grow, little My Project..."
    And it should have called "git init --bare some/git/my_project.git"
    And it should say "Initialized empty Git repository in some/git/my_project.git/"
    And it should say "Cloning into '<parent path>/my_project'..."
    And it should say "Created project structure in <parent path>/my_project."
    And ls should show the following files in "<parent path>/my_project":
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
    And it should say "Comitting..."
    And it should say "Dirt project init"
    And it should say "Pushed"
    And it should have called "git push origin master"
  Examples:
    | parent path            |
    | /a_path/to/the project |
    | /some/other/path       |

  #  dirt generate project --name NAME --face MEDIUM/ENGINE
  Scenario Outline: Generate project with face
    Given this feature is unimplemented
  Examples:
    | nope |
    |      |

  # dirt generate project --name NAME --location PATH --face MEDIUM/ENGINE
  Scenario Outline: Generate project with location and face
    Given this feature is unimplemented
  Examples:
    | nope |
    |      |

  # === Unhappy cases ====
  # dirt generate project
  Scenario: Generate project without name or location
    Given this feature is unimplemented

  # dirt generate project --name
  Scenario: Generate project but missing name arg
    Given this feature is unimplemented

  # dirt generate project --name test --location
  Scenario: Generate project but missing location arg
    Given this feature is unimplemented

  # dirt generate project --location path
  Scenario: Generate project with location but no name
    Given this feature is unimplemented


#  Scenario Outline: Running with just project flag
#    Given I am in "<parent_path>"
#    When I run dirt generate with:
#      | flag    | value          |
#      | project | <project_name> |
#    Then it should say "Time to grow, little <project_name>..."
#    And it should say "Created project structure in <parent_path>/<project_directory>."
#    And ls should show the following files in "<parent_path>/<project_directory>":
#      | path                                   |
#      | config                                 |
#      | dirt/contexts                          |
#      | dirt/contexts/roles                    |
#      | dirt/models                            |
#      | dirt/tests/behaviours                  |
#      | dirt/tests/behaviours/support          |
#      | dirt/tests/behaviours/step_definitions |
#      | dirt/tests/isolations                  |
#      | faces                                  |
#  Examples:
#    | parent_path           | project_directory | project_name     |
#    |                       | my_project        | My Project       |
#    | a_path/to/the project | my_project        | My Project       |
#    |                       | my_other_project  | My Other Project |
#    | some/other/path       | my_other_project  | My Other Project |
#
#  Scenario: it should require a project name
#    When I run dirt generate with no args
#    Then it should say "Usage: samling [options] arguments"