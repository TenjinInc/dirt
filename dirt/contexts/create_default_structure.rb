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

module Samling
  class CreateDefaultStructure < Dirt::Context
    def initialize(project_path)
      @project_path = Pathname.new(project_path)
    end

    def call
      project_name = @project_path.basename.to_s
      FileUtils.mkdir_p(@project_path)

      dirs = %w{config
                dirt/contexts
                dirt/contexts/roles
                dirt/models
                dirt/tests/behaviours
                dirt/tests/behaviours/support
                dirt/tests/behaviours/step_definitions
                dirt/tests/isolations
                faces}

      dirs.each do |path|
        FileUtils.mkdir_p(@project_path + path)
      end

      files_to_templates = {'.gitignore' => 'template.gitignore',
                            'Gemfile' => 'template.Gemfile',
                            "dirt/#{project_name}.rb" => 'template.project_name.rb',
                            'dirt/tests/behaviours/support/env.rb' => 'template.env.rb'}

      files_to_templates.each do |f, t|
        file = @project_path + f

        FileUtils.mkdir_p(file.dirname)
        File.open(file.to_s, 'w') do |file|
          specified_content = File.read(Pathname.new('config/templates/' + t).to_s)
          specified_content.gsub!('<project_name>', project_name)

          file.write(specified_content)
        end
      end
    end
  end
end