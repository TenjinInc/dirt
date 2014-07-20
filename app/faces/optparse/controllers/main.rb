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
          opts.banner = 'Usage: samling [options] arguments'

          opts.separator ''
          opts.separator 'Specific options:'

          # ===================================
          # Add option recognisers here
          # ===================================

          opts.on('-p', '--project NAME',
                  'The human-readable name of the new project. Put it in quotes if you want spaces.') do |name|
            options[:project_name] = name.titlecase
          end

          opts.on('-l', '--location PATH',
                  'The parent directory of the new project on the host machine (see --host).') do |path|
            options[:project_location] = path
          end

          opts.on('-h', '--host ADDRESS',
                  'The IP address or name of the device where the bare repository will be kept. Defaults to localhost.') do |host|
            options[:vcs_host] = host
          end

          opts.on('-u', '--user NAME',
                  'The username to be used to log into the host device. Defaults to the name of the user running this script.') do |name|
            options[:vcs_user] = name
          end
          # opts.on('--version',
          #         'Print program version and exit.') do |version|
          #   options[:version] = version
          # end
        end

        parser.parse!(args)

        config_options = YAML.load_file(options[:config_path] || './config/config.yml')

        options = config_options.merge(options)

        # Capture remaining, non-flag normal arguments
        options[:arguments] = args

        assert_required!(options, parser)

        return options
      end

      def assert_required!(options, parser)
        unless options[:project_name]
          puts parser
          exit
        end
      end

      def select_and_run_context(options)
        puts "Time to grow, little #{options[:project_name]}..."
        SpawnDirectoryStructure.run()
        puts "Created project structure in #{options[:project_location]}/#{options[:project_name].gsub(' ', '').underscore}."
      end
    end
  end
end