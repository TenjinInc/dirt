When(/^I run Samling with:$/) do |table|
  options = table.hashes.collect do |h|
    ["--#{h[:flag]}", "#{h[:value]}"]
  end.flatten

  input = StringIO.new
  out = StringIO.new
  err = StringIO.new

  Samling::Cli::Main.new(input, out, err).execute!(options)

  @output = out.string
end

When(/^I run Samling$/) do
  step('I run Samling with:', table([%w{flag value}]))
end