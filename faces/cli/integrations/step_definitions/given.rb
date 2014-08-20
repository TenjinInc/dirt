Given(/^this feature is unimplemented$/) do
  pending 'This feature is yet to be fleshed out.'
end

Given(/^I am in "(.*?)"$/) do |path|
  FileUtils.mkdir_p(path)
  @run_dir = path
end