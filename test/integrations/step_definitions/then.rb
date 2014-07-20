Then(/^it should say "(.*?)"$/) do |msg|
  @output.split("\n").should include msg
end

Then(/^there should be the following files:$/) do |table|
  pending 'check with ls to see if the files are actually there'
end

Then(/^there should( not)? be a( central)? git repository in "(.*?)"$/) do |exists, central, location|
  pending 'use ls to check if there is a .git repo in that file'
end