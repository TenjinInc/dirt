require './faces/cli/optparse/main.rb'

require './dirt/tests/behaviours/support/env'

require 'cucumber/rspec/doubles'

Before do
  @env_user = ENV['USER']
  @env_username = ENV['USERNAME']

  @exited = false
end

After do
  ENV['USER']= @env_user
  ENV['USERNAME'] = @env_username
end

class KernelExited < Exception

end
