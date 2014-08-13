Feature: create VCS repository

  # It may be that one day we want to separate bare creation to a switchable step,
  # but we don't need it yet - remiller

  Scenario Outline: local host
    When it creates a VCS bare under bare_path: "<bare_path>", and project_path: "<working_project_path>"
    Then it should run exactly:
      | command                                      |
      | git init --bare <bare_path>                  |
      | git clone <bare_path> <working_project_path> |
  Examples:
    | bare_path                     | working_project_path |
    | some/path.git                 | the/project/path     |
    | different/barish/location.git | another/directory    |

  Scenario: local host with incomplete bare name
    When it creates a VCS bare under bare_path: "some/path", and project_path: "the/project/path"
    Then it should run exactly:
      | command                                  |
      | git init --bare some/path.git            |
      | git clone some/path.git the/project/path |

  Scenario Outline: remote host
    When it creates a bare VCS under host: "<host>", user: "<user>", bare_path: "<bare_path>", and project_path: "<working_project_path>"
    Then it should run exactly:
      | command                                                    |
      | ssh <user>@<host> "git init --bare <bare_path>"            |
      | git clone <user>@<host>:<bare_path> <working_project_path> |
  Examples:
    | host     | user  | bare_path                     | working_project_path |
    | machine1 | userA | some/bare/path.git            | the/project/path     |
    | machine2 | userB | different/barish/location.git | another/directory    |

  Scenario: remote host with incomplete bare name
    When it creates a bare VCS under host: "machine1", user: "userA", bare_path: "some/bare/path", and project_path: "the/project/path"
    Then it should run exactly:
      | command                                                      |
      | ssh userA@machine1 "git init --bare some/bare/path.git"      |
      | git clone userA@machine1:some/bare/path.git the/project/path |