Then(/^it should say "(.*?)"$/) do |msg|
  (@output || '').split("\n").should include msg
end

Then(/^it should say the usage$/) do
  (@output || '').should include 'Usage:'
end

Then(/^ls should show the following files in "(.*?)":$/) do |location, table|
  Dir.chdir(location) do

    # ideally use `tree -ifd` instead

    paths = Dir[location + '/**/*']

    table.hashes.collect do |h|
      paths.should include h[:path]
    end
  end
end

Then(/^there should( not)? be a( central)? git repository in "(.*?)"$/) do |exists, central, location|
  pending 'use ls to check if there is a .git repo in that file'
end

Then(/^it should have called "(.*?)"$/) do |command|
  FakeFS.deactivate!
  history.should include command.shellsplit
  FakeFS.activate!
end

Then(/^it should exit with an error$/) do
  @exited.should be_true
end
