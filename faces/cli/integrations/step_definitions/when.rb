When(/^I run dirt generate with:$/) do |table|
  options = table.hashes.collect do |h|
    ["--#{h[:flag]}", "#{h[:value]}"]
  end.flatten

  input = StringIO.new
  out = StringIO.new
  err = StringIO.new

  @output = out.string

  Samling::Cli::Main.new(input, out, err).execute!(options)
end

When(/^I run dirt generate with no args$/) do
  expect { step('I run dirt generate with:', table([%w{flag value}])) }.to raise_error(SystemExit)
end