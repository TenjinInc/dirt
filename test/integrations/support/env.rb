require './app/faces/optparse/controllers/main.rb'

World do
  `ssh thor "rm -rf /var/git/test/"`
end