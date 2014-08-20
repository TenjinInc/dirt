require './dirt/dirt'
require 'rspec/matchers'

require 'fakefs/safe'
require 'aruba-doubles'

RSpec::Matchers.define :exist do
  match do |actual_path|
    File.exist?(actual_path) == true
  end

  failure_message_for_should do |actual|
    "expected '#{actual.to_s}' to exist"
  end
end

Before do
  ArubaDoubles::Double.setup

  double_cmd('git init --bare some/path.git', puts: 'Initialized empty Git repository in some/path.git/')
  double_cmd('git init --bare different/barish/location.git', puts: 'Initialized empty Git repository in different/barish/location.git/')

  double_cmd('ssh machine1 "git init --bare some/bare/path.git"', puts: 'Initialized empty Git repository in some/bare/path.git/')
  double_cmd('ssh machine2 "git init --bare different/barish/location.git"', puts: 'Initialized empty Git repository in different/barish/location.git/')

  double_cmd('git init --bare different/barish/location.git', puts: 'Initialized empty Git repository in different/barish/location.git/')

  double_cmd('git clone some/path.git', 'Cloning into \'/home/derp/test/my_project.git\'...')
  double_cmd('git clone different/barish/location.git', 'Cloning into \'/home/derp/test/my_other_project.git\'...')

  double_cmd('git add "/some/other/path/my_other_project/Gemfile"')
  double_cmd('git add "/some/other/path/my_other_project/.gitignore"')
  double_cmd('git add "/some/other/path/my_other_project/dirt/tests/behaviours/support/env.rb"')
  double_cmd('git add "/some/other/path/my_other_project/config/.gitkeep"')
  double_cmd('git add "/some/other/path/my_other_project/dirt/contexts/.gitkeep"')
  double_cmd('git add "/some/other/path/my_other_project/dirt/contexts/roles/.gitkeep"')
  double_cmd('git add "/some/other/path/my_other_project/dirt/models/.gitkeep"')
  double_cmd('git add "/some/other/path/my_other_project/dirt/tests/behaviours/.gitkeep"')
  double_cmd('git add "/some/other/path/my_other_project/dirt/tests/behaviours/support/.gitkeep"')
  double_cmd('git add "/some/other/path/my_other_project/dirt/tests/behaviours/step_definitions/.gitkeep"')
  double_cmd('git add "/some/other/path/my_other_project/dirt/tests/isolations/.gitkeep"')
  double_cmd('git add "/some/other/path/my_other_project/faces/.gitkeep"')

  double_cmd('git add "/a_path/to/the project/my_project/Gemfile"')
  double_cmd('git add "/a_path/to/the project/my_project/.gitignore"')
  double_cmd('git add "/a_path/to/the project/my_project/dirt/tests/behaviours/support/env.rb"')
  double_cmd('git add "/a_path/to/the project/my_project/config/.gitkeep"')
  double_cmd('git add "/a_path/to/the project/my_project/dirt/contexts/.gitkeep"')
  double_cmd('git add "/a_path/to/the project/my_project/dirt/contexts/roles/.gitkeep"')
  double_cmd('git add "/a_path/to/the project/my_project/dirt/models/.gitkeep"')
  double_cmd('git add "/a_path/to/the project/my_project/dirt/tests/behaviours/.gitkeep"')
  double_cmd('git add "/a_path/to/the project/my_project/dirt/tests/behaviours/support/.gitkeep"')
  double_cmd('git add "/a_path/to/the project/my_project/dirt/tests/behaviours/step_definitions/.gitkeep"')
  double_cmd('git add "/a_path/to/the project/my_project/dirt/tests/isolations/.gitkeep"')
  double_cmd('git add "/a_path/to/the project/my_project/faces/.gitkeep"')

  double_cmd('git commit -am "Dirt project init"')
  double_cmd('git push origin master')

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
      File.open(file, 'w+') { |file| file.write(content) }
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

def recent_history(n=1)
  unless @commands
    FakeFS.deactivate!
    @commands = history.to_a
    FakeFS.activate!
  end

  @commands.shift(n)
end

