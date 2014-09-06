#--
# Copyright (c) 2014 Tenjin Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

src_dir = File.expand_path('../dirt', __FILE__)
$LOAD_PATH.unshift(src_dir) unless $LOAD_PATH.include?(src_dir)

require 'dirt'

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
          opts.banner = 'Usage: dirt generate [options]'

          opts.separator ''
          opts.separator 'Specific options:'

          # ===================================
          # Add option recognisers here
          # ===================================

          opts.on('-n', '--name NAME',
                  'The human-readable name of the new project. Put it in quotes if you want spaces.') do |name|
            options[:project_name] = name.titlecase
          end

          opts.on('-l', '--location PATH',
                  'The parent directory of the new project on the local machine.') do |path|
            options[:project_parent] = Pathname.new(path)
          end

          opts.on('-b', '--bare-path PATH',
                  'The parent directory of the new git bare on the host machine. See --host.') do |path|
            options[:bare_path] = Pathname.new(path)
          end

          opts.on('-h', '--host ADDRESS',
                  'The IP address or name of the machine where the bare repository will be kept. Defaults to localhost.') do |host|
            options[:vcs_host] = host
          end

          opts.on('-u', '--user NAME',
                  'The username to be used to log into the host device. Defaults to the name of the user running this script. See --host.') do |name|
            options[:vcs_user] = name
          end

          # opts.on('-n', '--no-git',
          #         'Skip the git steps.') do |use_git|
          #   options[:use_vcs] = use_git
          # end

          # opts.on('--version',
          #         'Print program version and exit.') do |version|
          #   options[:version] = version
          # end
        end

        parser.parse!(args)

        # config_options = YAML.load_file(options[:config_path] || './config/config.yml')
        #
        # options = config_options.merge(options)

        options[:project_parent] ||= Pathname.new(Dir.pwd)
        options[:vcs_user] ||= ENV['USERNAME'] || ENV['USER']

        # Capture remaining, non-flag normal arguments
        # options[:arguments] = args

        assert_required!(options, parser)

        return options
      end

      def assert_required!(options, parser)
        unless options[:project_name] && options[:bare_path]
          puts parser
          @kernel.exit
        end
      end

      def select_and_run_context(options)
        project_directory = options[:project_name].gsub(' ', '').underscore
        project_directory = options[:project_parent].expand_path + project_directory

        puts "Time to grow, little #{options[:project_name]}..."

        # puts 'Skipping git steps.'
        CreateGitRepository.run(project_directory, options[:bare_path], options[:vcs_host], options[:vcs_user])

        puts CreateDefaultStructure.run(project_directory)

        puts CommitGitRepository.run(project_directory)
      end
    end
  end
end