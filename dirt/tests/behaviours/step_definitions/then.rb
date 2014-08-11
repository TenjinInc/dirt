Then(/^it should run "(.*?)"$/) do |command|
  FakeFS.deactivate!
  history.should include command.shellsplit
  FakeFS.activate!
end

Then(/^it should run git add on exactly the following paths in "(.*?)":$/) do |base_path, table|
  commands = table.hashes.collect do |h|
    path = Pathname.new(base_path) + Pathname.new(h[:path])

    command = "git add #{path}\n"
  end

  FakeFS.deactivate!
  history.should == commands.shellsplit
  FakeFS.activate!
end

Then(/^there should be exactly the following files|directories in "(.*?)":$/) do |location, table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then(/^it there should be \.gitkeep files in exactly the following directories$/) do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
end

Then(/^there should be file "(.*?)" from template "(.*?)"$/) do |expected_file, template_name|
  template_path = "templates/#{template_name}"

  pending # express the regexp above with the code you wish you had
end