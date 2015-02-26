#Dirt
Make best practices easy. Come play in the Dirt.

##Why Dirt

The goal of the Dirt project is to get back to basics. As our industry grows and matures, we must begin enforcing best practices, and self-regulating. 



That's why Dirt exists: to provide the common foundation upon which you can build software. 

> Wouldn't it be great if every software project supported and encouraged best-practices out of the box?

Dirt was born from the desire to have an extremely flexible software architecture and from the frustrations of repetitive project init procedures.
We know that test driven development, version control, and clear separation of responsibilities make software a hell of a lot easier to build and maintain. 
We found that when starting new projects, we were always setting up the same directories, and creating the same . 

###Features & Benefits
This is what Dirt and its architecture style gets you right now. 

 - **Versioning** Start with a git repository initialized.
 
 - **User orientation** Architecture oriented around how _people_ use it. Perfectly aligned with the agile philosophy.

 - **Sane file structure** Similar things go together.

 - **Consistency** Get yourself into gear quicker by standardizing the layout of your projects. 

 - **Platform Freedom** Web, mobile, desktop UI, CLI... Choose the appropriate interface for your project, or support more than one.  

 - **Clean Lines** Every part should do one thing and do it well. Core / Face / Persist dichotomy clarifies purpose. 

 - **Ready BDD** Cucumber test environments that work out of the box.

 - **Undead resistance +3** Great for those pesky lich infestations. 


##Usage
<!---There are a few variation on how you can use Dirt.-->

<!---[Generation](id: #generation)
[Generation](id: #generation)--->
 

###Project Generation
We'll take a look at a couple of scenarios first, but you can skip to the [full options listing](#full-options-listing) at the bottom. 

####Team - Project with common remote master 
####Solo - Local use only

```
dirt generate project --name NAME --location PATH  [--face PLATFORM[/ENGINE]]
```
#### Full Options Listing
```
dirt generate [options]
```

This is the full listing of option flags. See [Team](#team) or [Solo](#solo) for specific examples. 

| Flag                   | Default Value       | Description                                                                        |
| ---------------------- | -----------------   | ---------------------------------------------------------------------------------- |
| `-n, --name NAME`      |                     | The human-readable name of the new project. Put it in quotes if you want spaces.   |
| `-l, --location PATH`  | *Current directory* | The **parent** directory of the new project on the local machine.                  |
| `-h, --host ADDRESS`   | `localhost`         | The IP address or hostname of the machine where the bare repository will be kept.  |
| `-b, --bare-path PATH` | n/a                 | The parent directory of the new git bare on the host machine. _See also:_ `--host` |
| `-u, --user NAME`      | *Your username*     | The username to be used to log into the host device. _See also:_ `--host`          |

**Examples**
To create a new project called "*My New Project*" in `~/projects/my_new_project`
```
dirt generate project --name "My New Project" --location ~/projects/
```

Create a new project with a 
```
dirt generate p -n "My New Project" -l ~/projects/ --face web/sinatra
```
```
dirt generate face web/sinatra
```

###Face Generation
```
dirt generate face PLATFORM[/ENGINE]
```

<!---
###Core Generation
These generate some extremely common 

```
dirt generate context CLASSNAME
dirt generate model CLASSNAME
dirt generate role CLASSNAME
```
--->

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

##Helping out


###Roadmap
This is where we're headed.

 - **Face Generation** Web, CLI, and simple mobile. All including integration tests to justify their existence.  
 - **VCS independence** Written around Git right now, other VCSes should be supported, especially distributed ones. 
 - **Project Diffing** Wouldn't it be nice to know what in your project is different form the standards, or the templates?
 - **Architectural linting** Core files should only depend on core files. 
 - **Simple installation** The language and Dirt should just work out of the box. 
 - **Multilingual Support** These concepts aren't Ruby specific. They can easily apply to any modern language. Where [Cucumber](https://github.com/cucumber/cucumber) and [Gherkin](https://github.com/cucumber/cucumber/wiki/Gherkin) go, Dirt may follow. 
