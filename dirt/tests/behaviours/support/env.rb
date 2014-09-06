require './dirt/dirt'
require 'rspec/matchers'
require 'fakefs/safe'
require 'aruba-doubles'

Before do
  ArubaDoubles::Double.setup

  # git init
  double_cmd(%q{git init --bare some/git/my_project.git})
  double_cmd(%q{git init --bare different/bares/my_other_project.git})

  double_cmd(%q{ssh userA@machine1 "git init --bare some/git/my_project.git"})
  double_cmd(%q{ssh userB@machine1 "git init --bare some/git/my_project.git"})
  double_cmd(%q{ssh userA@machine2 "git init --bare different/bares/my_project.git"})
  double_cmd(%q{ssh userB@machine2 "git init --bare different/bares/my_project.git"})
  double_cmd(%q{ssh userB@machine2 "git init --bare different/bares/my_other_project.git"})

  # git clone
  double_cmd(%q{git clone "some/git/my_project.git" "a_path/to/the project/my_project"})
  double_cmd(%q{git clone "some/git/my_project.git" "some/other/path/my_project"})
  double_cmd(%q{git clone "different/bares/my_other_project.git" "some/other/path/my_other_project"})

  double_cmd(%q{git clone userA@machine1:some/git/my_project.git "a_path/to/the project/my_project"})
  double_cmd(%q{git clone userA@machine1:different/bares/my_other_project.git "some/other/path/my_other_project"})
  double_cmd(%q{git clone userB@machine1:some/git/my_project.git "a_path/to/the project/my_project"})
  double_cmd(%q{git clone userB@machine1:different/bares/my_other_project.git "some/other/path/my_other_project"})

  double_cmd(%q{git clone userA@machine2:some/git/my_project.git "a_path/to/the project/my_project"})
  double_cmd(%q{git clone userA@machine2:different/bares/my_other_project.git "some/other/path/my_other_project"})
  double_cmd(%q{git clone userB@machine2:some/git/my_project.git "a_path/to/the project/my_project"})
  double_cmd(%q{git clone userB@machine2:different/bares/my_other_project.git "some/other/path/my_other_project"})
  double_cmd(%q{git clone userB@machine2:different/bares/my_project.git "some/other/path/my_project"})

  # git add
  double_cmd(%q{git add "some/other/path/my_other_project/Gemfile"})
  double_cmd(%q{git add "some/other/path/my_other_project/.gitignore"})
  double_cmd(%q{git add "some/other/path/my_other_project/dirt/tests/behaviours/support/env.rb"})
  double_cmd(%q{git add "some/other/path/my_other_project/config/.gitkeep"})
  double_cmd(%q{git add "some/other/path/my_other_project/dirt/contexts/.gitkeep"})
  double_cmd(%q{git add "some/other/path/my_other_project/dirt/contexts/roles/.gitkeep"})
  double_cmd(%q{git add "some/other/path/my_other_project/dirt/models/.gitkeep"})
  double_cmd(%q{git add "some/other/path/my_other_project/dirt/tests/behaviours/.gitkeep"})
  double_cmd(%q{git add "some/other/path/my_other_project/dirt/tests/behaviours/support/.gitkeep"})
  double_cmd(%q{git add "some/other/path/my_other_project/dirt/tests/behaviours/step_definitions/.gitkeep"})
  double_cmd(%q{git add "some/other/path/my_other_project/dirt/tests/isolations/.gitkeep"})
  double_cmd(%q{git add "some/other/path/my_other_project/faces/.gitkeep"})

  double_cmd(%q{git add "a_path/to/the project/my_project/Gemfile"})
  double_cmd(%q{git add "a_path/to/the project/my_project/.gitignore"})
  double_cmd(%q{git add "a_path/to/the project/my_project/dirt/tests/behaviours/support/env.rb"})
  double_cmd(%q{git add "a_path/to/the project/my_project/config/.gitkeep"})
  double_cmd(%q{git add "a_path/to/the project/my_project/dirt/contexts/.gitkeep"})
  double_cmd(%q{git add "a_path/to/the project/my_project/dirt/contexts/roles/.gitkeep"})
  double_cmd(%q{git add "a_path/to/the project/my_project/dirt/models/.gitkeep"})
  double_cmd(%q{git add "a_path/to/the project/my_project/dirt/tests/behaviours/.gitkeep"})
  double_cmd(%q{git add "a_path/to/the project/my_project/dirt/tests/behaviours/support/.gitkeep"})
  double_cmd(%q{git add "a_path/to/the project/my_project/dirt/tests/behaviours/step_definitions/.gitkeep"})
  double_cmd(%q{git add "a_path/to/the project/my_project/dirt/tests/isolations/.gitkeep"})
  double_cmd(%q{git add "a_path/to/the project/my_project/faces/.gitkeep"})

  # git commit/push
  double_cmd(%q{git commit -am "Dirt project init"', puts: 'Dirt project init})
  double_cmd(%q{git push origin master})

  FakeFS::FileSystem.clear

  # clone all config files into the fake file system
  Dir['./config/**/*'].each do |file|
    FakeFS.deactivate!

    if File.directory? file
      FakeFS.activate!
      FileUtils.mkdir(file)
    else
      content = File.read(file)
      FakeFS.activate!
      FileUtils.mkdir_p(File.dirname(file))
      FileUtils.touch(file)
      File.open(file, 'w+') { |f| f.write(content) }
    end
  end
  FakeFS.activate!
end

World(ArubaDoubles)

After do
  FakeFS::FileSystem.clear
  FakeFS.deactivate!

  ArubaDoubles::Double.teardown
  history.clear
end


