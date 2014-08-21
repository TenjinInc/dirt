require './faces/cli/optparse/main.rb'

require './dirt/tests/behaviours/support/env'

require 'cucumber/rspec/doubles'

Before do
  @exited = false
end

class KernelExited < Exception

end