Given(/^a step that is unimplemented$/) do
  pending 'Finish defining this test!'
end

Given(/^the following directories exist:$/) do |table|
  table.hashes.each do |h|
    FileUtils.mkdir_p(h[:path])
  end
end

Given(/^the default structure exists in "(.*?)"$/) do |project_dir|
  project_dir = Pathname.new(project_dir)
  Samling::SpawnDirectoryStructure.run(project_dir.dirname, project_dir.basename)
  Samling::PopulateDefaultFiles.run(project_dir)
end