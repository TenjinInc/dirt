require 'rspec/matchers'

RSpec::Matchers.define :exist do
  match do |actual_path|
    File.exist?(actual_path) == true
  end

  failure_message_for_should do |actual|
    "expected '#{actual.to_s}' to exist"
  end
end

def recent_history(n=1)
  unless @commands
    FakeFS.deactivate!
    @commands = history.to_a
    FakeFS.activate!
  end

  @commands.shift(n)
end