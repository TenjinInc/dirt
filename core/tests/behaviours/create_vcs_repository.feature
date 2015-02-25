Feature: create VCS repository

  # It may be that one day we want to separate bare creation to a switchable step,
  # but we don't need it yet - remiller

  Scenario Outline: local host
    When it creates a VCS bare under bare_path: "<given_bare_path>", and project_path: "<working_project_path>"
    Then it should run exactly:
      | command                                              |
      | git init --bare <created_bare_path>                  |
      | git clone <created_bare_path> <working_project_path> |
  Examples:
    | working_project_path | given_bare_path | created_bare_path           |
    | the/project/path     | some            | some/path.git               |
    | another/project      | different/bares | different/bares/project.git |

  Scenario Outline: remote host
    When it creates a bare VCS under host: "<host>", user: "<user>", bare_path: "<given_bares_path>", and project_path: "<working_project_path>"
    Then it should run exactly:
      | command                                                            |
      | ssh <user>@<host> "git init --bare <created_bare_path>"            |
      | git clone <user>@<host>:<created_bare_path> <working_project_path> |
  Examples:
    | host     | user  | working_project_path     | given_bares_path | created_bare_path                    |
    | machine1 | userA | the/project/my_project   | some/git/        | some/git/my_project.git              |
    | machine2 | userB | another/my_other_project | different/bares  | different/bares/my_other_project.git |