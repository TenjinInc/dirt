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
      @project_root = Pathname.new(project_path)
    end

    def call
      FileUtils.mkdir_p(@project_root)

      dirs = %w{core/contexts
                core/contexts/roles
                core/models
                core/tests/isolations
                faces
                persist}

      dirs.each do |path|
        FileUtils.mkdir_p(@project_root + path)
      end

      files_to_templates = {'.gitignore' => 'template.gitignore',
                            'Gemfile' => 'template.Gemfile',
                            "core/project_name.rb" => 'template.project_name.rb',
                            'core/tests/behaviours/support/env.rb' => 'template.env.rb',
                            'core/tests/behaviours/step_definitions/given.rb' => nil,
                            'core/tests/behaviours/step_definitions/when.rb' => nil,
                            'core/tests/behaviours/step_definitions/then.rb' => nil}

      Generating.new(files_to_templates).generate_templates(@project_root)

      "Created project structure in #{@project_root.to_s}."
    end
  end
end