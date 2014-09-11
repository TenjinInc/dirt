Given(/^a step that is unimplemented$/) do
  pending 'Finish defining this test!'
end

Given(/^the following (files|directories) exist:$/) do |type, table|
  table.hashes.each do |h|
    if type == 'directories'
      FileUtils.mkdir_p(h[:path])
    else
      FileUtils.mkdir_p(File.dirname(h[:path]))
      FileUtils.touch(h[:path])
    end
  end
end

Given(/^the default structure exists in "(.*?)"$/) do |project_dir|
  Samling::CreateDefaultStructure.run(project_dir)
end