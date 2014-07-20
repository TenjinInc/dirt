Then(/^it should say "(.*?)"$/) do |msg|
  (@output || '').split("\n").should include msg
end

Then(/^ls should show the following files in "(.*?)":$/) do |location, table|
  paths = Dir[location]

  table.hashes.collect do |h|
    paths.should include h[:path]
  end
end

Then(/^there should( not)? be a( central)? git repository in "(.*?)"$/) do |exists, central, location|
  pending 'use ls to check if there is a .git repo in that file'
end