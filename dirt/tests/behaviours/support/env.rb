require './dirt/samling'

require 'fakefs/safe'
require 'aruba-doubles'

Before do
  ArubaDoubles::Double.setup

  double_cmd('git init --bare some/path.git', puts: 'Initialized empty Git repository in some/path.git/')
  double_cmd('git init --bare different/barish/location.git', puts: 'Initialized empty Git repository in different/barish/location.git/')

  double_cmd('ssh machine1 "git init --bare some/bare/path.git"', puts: 'Initialized empty Git repository in some/bare/path.git/')
  double_cmd('ssh machine2 "git init --bare different/barish/location.git"', puts: 'Initialized empty Git repository in different/barish/location.git/')
  double_cmd('ssh machine2 "git init --bare different/barish/location.git"', puts: 'Initialized empty Git repository in different/barish/location.git/')

  double_cmd('git init --bare different/barish/location.git', puts: 'Initialized empty Git repository in different/barish/location.git/')

  double_cmd('git clone some/path.git', 'Cloning into \'/home/derp/test/my_project.git\'...')
  double_cmd('git clone different/barish/location.git', 'Cloning into \'/home/derp/test/my_other_project.git\'...')

  double_cmd('git add')
  double_cmd('git commit')
  double_cmd('git push')

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

