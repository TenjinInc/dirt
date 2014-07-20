require './app/faces/optparse/controllers/main.rb'

# require 'fakefs/safe'
#
# Before do
#   config_path = './config/config.yml'
#   config = File.read(config_path)
#   FakeFS.activate!
#   File.open(config_path, 'w') { |file| file.write(config) }
# end
#
# After do
#   FakeFS::FileSystem.clear
#   FakeFS.deactivate!
# end

# World do
#   # `ssh thor "rm -rf /var/git/test/"`
# end