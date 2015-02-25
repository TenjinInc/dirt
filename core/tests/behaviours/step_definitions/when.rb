When(/^I create a new project in "(.*?)"$/) do |project_path|
  Samling::CreateDefaultStructure.run(project_path)
end

When(/^it creates a VCS bare under bare_path: "(.*?)", and project_path: "(.*?)"$/) do |bare_path, project_path|
  step "it creates a bare VCS under host: \"\", user: \"\", password: \"\", bare_path: \"#{bare_path}\", and project_path: \"#{project_path}\""
end

When(/^it creates a bare VCS under host: "(.*?)", user: "(.*?)", bare_path: "(.*?)", and project_path: "(.*?)"$/) do |host, user, bare_path, project_path|
  Samling::CreateGitRepository.run(project_path, bare_path, host, user)
end

When(/^it commits all files and directories in "(.*?)"$/) do |path|
  Samling::CommitGitRepository.run(path)
end

# faces

When(/^I create a new basic face "(.*?)" at "(.*?)"$/) do |face_name, root_path|
  Samling::CreateBasicFace.run(root_path, face_name)
end