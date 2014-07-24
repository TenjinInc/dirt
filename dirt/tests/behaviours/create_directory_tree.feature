Feature: it should create the expected directory tree

  Scenario Outline: the project root directory does not exist
    When I create a new project "<project_name>"
    Then there should be the following files:
      | path                                       |
      | <project_name>/app/contexts/.gitkeep       |
      | <project_name>/app/contexts/roles/.gitkeep |
      | <project_name>/app/faces/.gitkeep          |
      | <project_name>/app/models/.gitkeep         |
      | <project_name>/config/.gitkeep             |
      | <project_name>/test/behaviours/.gitkeep    |
      | <project_name>/test/factories/.gitkeep     |
      | <project_name>/test/integrations/.gitkeep  |
  Examples:
    | project_name  |
    | test_project  |
    | other_project |