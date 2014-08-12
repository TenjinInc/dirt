require './dirt/samling'

require 'fakefs/safe'
require 'aruba-doubles'

Before do
  ArubaDoubles::Double.setup

  double_cmd('git init --bare my_project.git', puts: 'Initialized empty Git repository in my_project.git/')
  double_cmd('git init --bare /var/git/my_other_project.git', puts: 'Initialized empty Git repository in /var/git/my_other_project.git/')

  double_cmd('git clone thor:/var/git/my_project.git', 'Cloning into \'/home/derp/test/my_project.git\'...')
  double_cmd('git clone thor:/var/git/my_other_project.git', 'Cloning into \'/home/derp/test/my_other_project.git\'...')

  double_cmd('git add')
  double_cmd('git commit')
  double_cmd('git push')

  FakeFS::FileSystem.clear

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

  # config_path = './config/config.yml'
  # config = File.read(config_path)
  #
  # FakeFS.activate!
  #
  # FileUtils.mkdir(File.dirname(config_path))
  # FileUtils.touch(config_path)
  #
  # File.open(config_path, 'w') { |file| file.write(config) }
end

World(ArubaDoubles)

# World do
#   # `ssh thor "rm -rf /var/git/test/"`
# end

After do
  FakeFS::FileSystem.clear
  FakeFS.deactivate!

  ArubaDoubles::Double.teardown
  history.clear
end

