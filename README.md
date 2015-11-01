#Dirt
Make best practices easy. Come play in the Dirt.

##Why Dirt
Good design is when the easiest usage and the correct usage are one in the same. 

Best practices, however, are often an extra effort; many require configuration every time you start a new project.
Newbies are too busy learning to put in that effort and that quickly develops into bad habits. 
Masters find best practices useful, but routine and boring. So we asked ourselves:
 
> What if there was a tool to make best practices simple or even automatic? 

Dirt is the answer to this question.

It exists because we wanted a toolset to automatically set us up for:
 - Behaviour Driven Development (BDD)
 - User Story Orientation
 - A simple, standard project directory structure
 - Clear separation of concerns - thin views, thin persistence, thick core. 
 - Use of modern version control systems 
 - Code analysis & metrics.  
 
**That's the goal of Dirt: make best practices dead easy.** 

##Features
This is what Dirt gets you right now:

 - **Helpful defaults** Logical directory tree and some useful default meta files
 
 - **Versioning** Start with a git repository initialized, a populated .gitignore, and all default files already committed. 
 
 - **Ready BDD** Working [Cucumber](https://github.com/cucumber/cucumber) test environments and a default Gemfile to support them.

 - **Undead resistance +3** Great for those pesky lich infestations.
 
###Roadmap
This is where we're headed. If you want to help make it a reality, get in touch!

 - Making [ROM](rom-rb.org) the official recommended persistence library
 - **Face Generation** Web, CLI, and simple mobile. All including integration tests to justify their existence.  
 - **VCS independence** Written around Git right now, other VCSes should be supported, especially distributed ones. 
 - **Project Diffing** Wouldn't it be nice to know what in your project is different form the standards, or the templates?
 - **Architectural linting** Core files should only depend on core files. 
 - **Licence Injection** Applying the licence to all source files should be easy, and optional.   
 - **Simple installation** The language and Dirt should just work out of the box. 
 - **Multilingual Support** These concepts aren't Ruby specific. They can easily apply to any modern language. Where [Cucumber](https://github.com/cucumber/cucumber) and [Gherkin](https://github.com/cucumber/cucumber/wiki/Gherkin) go, Dirt may follow. 
 - ... Plus some other experimental ideas that BDD enable

## Prerequisites
Dirt requires that you have already installed [linux or unix](http://www.ubuntu.com/), [git](http://git-scm.com/book/en/v2/Getting-Started-Installing-Git), [ruby](https://www.ruby-lang.org/en/documentation/installation/).


## Installation
Dirt is an executable gem. To install it, run:
```
gem install dirt
```

You can now run dirt on the command line!

##Usage

###Project Generation

Generating a project will give you a project directory that looks like:

```
core/
├─── contexts/
│    └─────── roles/
├── models/
├── tests/
│   ├──── behaviours/
│   │     ├───────── step_definitions/
│   │     │          ├── given.rb
│   │     │          ├── then.rb
│   │     │          └── when.rb
│   │     └───────── support/
│   │                └────── env.rb
│   └───── isolations/
└── example_project.rb
faces/
persist/
Gemfile
.gitignore
```

We'll take a look at a couple of scenarios first: remote host and local host. 

*First, a note about git and dirt*
Usually, git stores history information in a .git file within your project directory. You can make a *bare* that is a 
folder with just the history information, and no actual project files. Then, you can point multiple regular git 
repository's to the bare, and it can act as a shared history.   

Dirt has two intended modes: having a git bare on a remote machine, or on your local machine. 

####Remote Bare Host
Intended for teams, this scenario will not only create a local project and git repository, but will also create a 
Git bare in a remote location. 
```
dirt generate project --name PROJECT_NAME --location PATH --host HOST_NAME --bare-path PATH
```

*Example*
We would like a new project:
 - called "*Our Project*"
 - saved in `~/projects/our_project`
 - with a git bare repository saved on a machine called *dresden*, and in `/var/git/our_project.git` 
 
So we'd use:

```
dirt generate project --name "Our Project" --location ~/projects/ --host dresden --bare-path /var/git/ 
```

####Local Bare Host
Even if you're building solo, you should have a bare repository to act as a sort of backup. Besides, you never know if you'll gain 
teammates, and having a bare ready to copy to a remote machine is very handy.   

This is a lot like the remote machine scenario above, but we don't need to provide the `--host` or `--bare-path`.

```
dirt generate project --name PROJECT_NAME --location PATH
```

*Example*
To have a new project called "*My New Project*" in `~/projects/my_new_project`, use:

```
dirt generate project --name "My New Project" --location ~/projects/
```

#### Full Listing
```
dirt generate [options]
```

This is the full listing of generation flags. 

| Flag                   | Default Value       | Description                                                                        |
| ---------------------- | -----------------   | ---------------------------------------------------------------------------------- |
| `-n, --name NAME`      |                     | The human-readable name of the new project. Put it in quotes if you want spaces.   |
| `-l, --location PATH`  | *Current directory* | The **parent** directory of the new project on the local machine.                  |
| `-h, --host ADDRESS`   | `localhost`         | The IP address or hostname of the machine where the bare repository will be kept.  |
| `-b, --bare-path PATH` | n/a                 | The **parent** directory of the new git bare on the host machine. _See also:_ `--host` |
| `-u, --user NAME`      | *Your username*     | The username to be used to log into the host device. _See also:_ `--host`          |

##Template variables
In the template files, there are some times that you need dynamic data insertion. 

These are the variables accessible to the template engine. Any instance of these tags will be replaced by the appropriate data.  

| Tag                   | Description                                           | Default Value              | Example       |
| --------------------- | ----------------------------------------------------- | -------------------------- | ------------- |
| `<project_name>`      | The human-readable name of the project.               |                            | My Project    |
| `<project_directory>` | The snake-case name of the project.                   |                            | my_project    |
| `<project_module>`    | The module name of the project.                       |                            | MyProject     |
| `<ruby_version>`      | The version of ruby that your project should support. | `ruby --version`           | 1.9.3         |
| `<user_name>`         | The name of the user running dirt.                    | _your name_                | Bob Guardian  |
| `<user_website>`      | The website to be associated with the project.        |                            | www.tenjin.ca |
