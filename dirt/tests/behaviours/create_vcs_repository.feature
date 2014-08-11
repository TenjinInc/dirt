Feature: create VCS repository

  # It may be that one day we want to separate bare creation to a switchable step,
  # but we don't need it yet - remiller

  Scenario Outline: local host
    When it creates a local VCS bare under bare_path: "<given_bare_path>", and project_path: "<working_project_path>"
    Then it should run "git init --bare <created_bare_path>"
    And it should run "git clone <created_bare_path> <working_project_path>"
  Examples:
    | given_bare_path               | created_bare_path             | working_project_path |
    | some/path.git                 | some/path.git                 | the/project/path     |
    | different/barish/location.git | different/barish/location.git | another/directory    |
    | different/barish/location     | different/barish/location.git | another/directory    |


  Scenario Outline: remote host
    When it creates a remote bare VCS under user: "<user>\@<host>", password: "<password>", bare_path: "<given_bare_path>", and project_path: "<working_project_path>"
    Then it should run "ssh thor "git init --bare <created_bare_path>""
    And it should run "git clone <created_bare_path> <working_project_path>"
  Examples:
    | host     | user  | password | given_bare_path               | created_bare_path             | working_project_path |
    | machine1 | userA | sekret   | some/bare/path.git            | some/bare/path.git            | the/project/path     |
    | machine2 | userB | sekret2  | different/barish/location.git | different/barish/location.git | another/directory    |
    | machine2 | userB | sekret2  | different/barish/location     | different/barish/location.git | another/directory    |