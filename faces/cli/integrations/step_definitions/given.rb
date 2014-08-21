Given(/^this feature is unimplemented$/) do
  pending 'This feature is yet to be fleshed out.'
end

Given(/^I am in "(.*?)"$/) do |path|
  FileUtils.mkdir_p(path)
  @run_dir = path
end

Given(/^that I am logged in as "(.*?)" on (windows|linux)$/) do |username, platform|
  if platform == 'linux'
    ENV['USER'] = username
  else
    ENV['USERNAME'] = username
  end
end