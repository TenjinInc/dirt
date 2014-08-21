When(/^I generate a project with:$/) do |table|
  Dir.chdir(@run_dir || Dir.pwd) do
    options = table.hashes.collect do |h|
      ["--#{h[:flag]}", "#{h[:value]}"]
    end.flatten

    input = StringIO.new
    out = StringIO.new
    err = StringIO.new
    kernel = double('kernel')

    kernel.stub(:exit) do
      raise KernelExited
    end

    @output = out.string

    begin
      Samling::Cli::Main.new(input, out, err, kernel).execute!(options)
    rescue KernelExited
      @exited = true
    end
  end
end

When(/^I run dirt generate with no args$/) do
  expect { step('I run dirt generate with:', table([%w{flag value}])) }.to raise_error(SystemExit)
end