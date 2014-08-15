Then(/^it should run "(.*?)"$/) do |command|
  FakeFS.deactivate!
  history.should include command.shellsplit
  FakeFS.activate!
end

Then(/^it should run exactly:$/) do |table|
  commands = table.hashes.collect do |h|
    h[:command].shellsplit
  end

  FakeFS.deactivate!
  history.to_a.should == commands
  FakeFS.activate!
end

Then(/^it should run git add on exactly the following files in "(.*?)":$/) do |base_path, table|
  expected_commands = table.hashes.collect do |h|
    path = Pathname.new(base_path) + Pathname.new(h[:path])

    "git add \"#{path}\"".shellsplit
  end

  FakeFS.deactivate!
  run_commands = history.select { |c| c[1] == 'add' }
  FakeFS.activate!

  expected_commands =~ run_commands
end

Then(/^there should be exactly the following files|directories in "(.*?)":$/) do |location, table|
  created_files = Dir.glob(location + '/**/*')
  expected_files = table.hashes.collect { |h| (Pathname.new(location) + h[:path]).to_s }

  created_files.should =~ expected_files
end

Then(/^it there should be \.gitkeep files in exactly the following directories of "(.*?)"$/) do |project_directory, table|
  table.hashes.each do |h|
    expected_file = (Pathname.new(project_directory) + h[:path]) + '.gitkeep'
    expected_file.should exist
    expected_file.file?.should be_true
  end
end

Then(/^there should be files for "(.*?)" from templates:$/) do |project_name, table|
  created_files = table.hashes.collect do |h|
    File.exists?(h[:path]).should be_true
    File.read(h[:path])
  end

  FakeFS.deactivate!
  templates = table.hashes.collect do |h|
    File.read("./config/templates/#{h[:template]}").gsub('<project_name>', project_name)
  end
  FakeFS.activate!

  created_files.should =~ templates
end