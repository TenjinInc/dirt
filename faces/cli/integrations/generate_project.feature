Feature: it should create new project with its default contents and an accompanying git repo

  # === Happy cases ====
  # dirt generate project --name NAME --bare-path PATH
  Scenario Outline: generate project with just name, assume location is CWD
    Given I am in "<parent path>"
    When I generate a project with:
      | flag      | value        |
      | name      | <given name> |
      | bare-path | <bare path>  |
    Then it should say "Time to grow, little <displayed name>..."
    And it should have called "git init --bare <bare path>/<project directory>.git"
    And ls should show the following files in "<parent path>/<project directory>":
      | path                                   |
      | core/contexts                          |
      | core/contexts/roles                    |
      | core/models                            |
      | core/tests/behaviours                  |
      | core/tests/behaviours/support          |
      | core/tests/behaviours/step_definitions |
      | core/tests/isolations                  |
      | faces                                  |
      | persist                                 |
    And it should say "Created project structure in <parent path>/<project directory>."
    And it should say "Comitting and pushing..."
    And it should have called "git --git-dir "<parent path>/<project directory>/.git" --work-tree "<parent path>/<project directory>" push origin master"
  Examples:
    | given name       | displayed name   | parent path            | project directory | bare path       |
    | my project       | My Project       | /a_path/to/the project | my_project        | some/git        |
    | my other project | My Other Project | /some/other/path       | my_other_project  | different/bares |

  # dirt generate project --name NAME --location PATH --bare-path PATH
  Scenario Outline: generate project with location
    Given I am in "/"
    When I generate a project with:
      | flag      | value         |
      | name      | my project    |
      | bare-path | some/git      |
      | location  | <parent path> |
    And it should have called "git init --bare some/git/my_project.git"
    And it should say "Created project structure in <parent path>/my_project." somewhere
    And it should have called "git --git-dir "<parent path>/my_project/.git" --work-tree "<parent path>/my_project" push origin master"
  Examples:
    | parent path            |
    | /a_path/to/the project |
    | /some/other/path       |

    # dirt generate project --name NAME --bare-path PATH --host HOSTNAME
  Scenario Outline: generate project with host name, assume user
    Given I am in "<project path>"
    And that I am logged in as "<user>" on <platform>
    When I generate a project with:
      | flag      | value       |
      | name      | my project  |
      | bare-path | <bare path> |
      | host      | <host>      |
    And it should have called "ssh <user>\@<host> "git init --bare <bare path>/my_project.git""
    And it should say "Created project structure in <project path>/my_project." somewhere
    And it should have called "git --git-dir "<project path>/my_project/.git" --work-tree "<project path>/my_project" push origin master"
  Examples:
    | platform | host     | user  | bare path       | project path           |
    | linux    | machine1 | userA | some/git        | /a_path/to/the project |
    | windows  | machine1 | userA | some/git        | /a_path/to/the project |
    | linux    | machine2 | userB | different/bares | /some/other/path       |
    | windows  | machine2 | userB | different/bares | /some/other/path       |

  # dirt generate project --name NAME --bare-path PATH --host HOSTNAME --user USER
  Scenario Outline: generate project with host name and user
    Given I am in "<project path>"
    When I generate a project with:
      | flag      | value       |
      | name      | my project  |
      | bare-path | <bare path> |
      | host      | <host>      |
      | user      | <user>      |
    And it should have called "ssh <user>\@<host> "git init --bare <bare path>/my_project.git""
    And it should say "Created project structure in <project path>/my_project." somewhere
    And it should have called "git --git-dir "<project path>/my_project/.git" --work-tree "<project path>/my_project" push origin master"
  Examples:
    | host     | user  | bare path       | project path           |
    | machine1 | userA | some/git        | /a_path/to/the project |
    | machine2 | userB | different/bares | /some/other/path       |

  #  dirt generate project --name NAME --face PLATFORM/ENGINE
  Scenario Outline: Generate project with face
    Given this feature is unimplemented
  Examples:
    | nope |
    |      |

  # dirt generate project --name NAME --location PATH --face PLATFORM/ENGINE
  Scenario Outline: Generate project with location and face
    Given this feature is unimplemented
  Examples:
    | nope |
    |      |

  # === Unhappy cases ====
  # dirt generate project
  Scenario: Generate project without name
    When I generate a project with:
      | flag      | value    |
      | bare-path | anything |
    Then it should say the usage
    And it should exit with an error

  # dirt generate project
  Scenario: Generate project without bare path
    When I generate a project with:
      | flag | value    |
      | name | anything |
    Then it should say the usage
    And it should exit with an error


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
#      | core/contexts                          |
#      | core/contexts/roles                    |
#      | core/models                            |
#      | core/tests/behaviours                  |
#      | core/tests/behaviours/support          |
#      | core/tests/behaviours/step_definitions |
#      | core/tests/isolations                  |
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