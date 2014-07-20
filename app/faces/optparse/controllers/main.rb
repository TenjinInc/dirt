require './app/samling'

require 'optparse'
require 'yaml'

module Samling
  module Cli
    # Main command line interface (CLI) controller. Handles standard CLI input.
    class Main
      # Defines each of the standard OS interfaces to default values, unless
      # otherwise specified.
      def initialize(stdin=STDIN, stdout=STDOUT, stderr=STDERR, kernel=Kernel)
        $stdin, $stdout, $stderr = stdin, stdout, stderr

        @kernel = kernel
      end

      # The primary invocation method for the application.
      # It sets up the components of the application as
      # required by the input arguments, then runs the Contexts.
      def execute!(argv)
        options = parse_args(argv)

        select_and_run_context(options)
      end

      # Parses the argument array as received from the CLI.
      def parse_args(args)
        options = {}
        args ||= []

        parser = OptionParser.new do |opts|
          opts.banner = "Usage: samling [options] [arguments]"

          opts.separator ""
          opts.separator "Specific options:"

          # Add option recognisers here

          opts.on("--version",
                  "Print program version.") do |ccid|
            options[:auth_ccid] = ccid
          end
        end

        parser.parse!(args)

        if options[:config_path]
          config_options = YAML.load_file(options[:config_path])

          options = config_options.merge(options)
        end

        # Capture remaining, non-flag normal arguments
        options[:arguments] = args

        return options
      end

      def select_and_run_context(options)
        # Put your context routing code here.
      end
    end
  end
end