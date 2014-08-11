Feature: create VCS repository

  # It may be that one day we want to separate bare creation to a switchable step,
  # but we don't need it yet - remiller



  Scenario Outline: local host
    When it creates a local VCS bare under bare_path: "<bare_path>", and project_path: "<project_path>"
    Then it should run "git init --bare <bare_path>"
    And it should run "git clone <created_bare_path> <target_path>"
  Examples:
    | bare_path | project_path     |
    | some/path | the/project/path |

  Scenario Outline: remote host
    When it creates a remote bare VCS under user: "<user>@<bare_host>", password: "<password>", bare_path: "<bare_path>", and project_path: "<project_path>"
    Then it should run "ssh thor "git init --bare /var/git/$project_name.git""
    And it should run "git clone <created_bare_path> <target_path>"
  Examples:
    | user  | password | bare_path                     | project_path      |
    | userA | sekret   | some/bare/path.git            | the/project/path  |
    | userB | sekret2  | different/barish/location.git | another/directory |


  Scenario: given path has .git or not
    Given a step that is unimplemented