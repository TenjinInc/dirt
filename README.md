Dirt
-------

Start your projects right with a strong, well-organised directory structure.
 
Usage: 
dirt generate project --name NAME --location PATH  [--face MEDIUM[/ENGINE]]
dirt generate face MEDIUM[/ENGINE]
dirt generate context CLASSNAME
dirt generate model CLASSNAME
dirt generate role CLASSNAME

Some examples:
dirt generate project --name "My New Project" --location ~/projects/
dirt generate p -n "My New Project" -l ~/projects/ --face web/sinatra
dirt generate face web/sinatra

Template variables:

| Tag                 | Description                                                  | Default Value              | Example       |
| ------------------- | ------------------------------------------------------------ | -------------------------- | ------------- |
| <project_name>      | The human-readable name of the project.                      |                            | My Project    |
| <project_directory> | The snake-case name of the project.                          |                            | my_project    |
| <project_module>    | The module name of the project.                              |                            | MyProject     |
| <ruby_version>      | The version of ruby that the project is expected to support. | `ruby --version`           | 1.9.3         |
| <user_name>         | The name of the user running dirt.                           | (your name)                | Bob Guardian  |
| <user_website>      | The website to be associated with the project.               |                            | www.tenjin.ca |