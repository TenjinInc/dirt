When(/^I create a new project "(.*?)" at "(.*?)"$/) do |project_name, parent_path|
  Samling::SpawnDirectoryStructure.run(parent_path, project_name)
end

When(/^it creates project files in "(.*?)"$/) do |project_root|
  Samling::PopulateDefaultFiles.run(project_root)
end

When(/^it creates a VCS bare under bare_path: "(.*?)", and project_path: "(.*?)"$/) do |bare_path, project_path|
  step "it creates a bare VCS under host: \"\", user: \"\", password: \"\", bare_path: \"#{bare_path}\", and project_path: \"#{project_path}\""
end

When(/^it creates a bare VCS under host: "(.*?)", user: "(.*?)", bare_path: "(.*?)", and project_path: "(.*?)"$/) do |host, user, bare_path, project_path|
  Samling::CreateGitRepository.run(project_path, bare_path, host, user)
end

When(/^it commits all files and directories$/) do
  Samling::CommitGitRepository.run(project_path)
end