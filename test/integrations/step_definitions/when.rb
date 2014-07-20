When(/^I run Samling with:$/) do |table|
  options = table.hashes.collect do |h|
    ["--#{h[:flag]}", "\"#{h[:value]}\""]
  end

  Samling::Cli::Main.new.execute!(options)
end

When(/^I run Samling$/) do
  step('I run Samling with:', '|flag|value|')
end