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
  class CreateBasicFace < Dirt::Context
    def initialize(root_path, face_name)
      @root_path = Pathname.new(root_path)
      @face_root = Pathname.new('faces') + face_name
    end

    def call
      dirs = %w{integrations/support
                integrations/step_definitions}

      dirs.each do |f|
        FileUtils.mkdir_p(@root_path + @face_root + f)
      end

      files_to_templates = {(@face_root + 'integrations/support/env.rb').to_s => 'template.env.rb'}

      # this isn't a great way to find the dir, but at the time of writing, there isn't a nicer one -remiller
      # templates_dir = Pathname.new(__FILE__).dirname

      # files_to_templates.each do |f, t|
      #   File.open((@face_root + f).to_s, 'w') do |file|
      #     specified_content = File.read(Pathname.new('persist/templates/' + t).to_s)
      #     specified_content.gsub!('<project_name>', @root_path.basename.to_s)
      #
      #     file.write(specified_content)
      #   end
      # end

      Generating.new(files_to_templates).generate_templates(@root_path)

      FileUtils.touch((@root_path + @face_root + 'integrations/step_definitions/given.rb').to_s)
      FileUtils.touch((@root_path + @face_root + 'integrations/step_definitions/when.rb').to_s)
      FileUtils.touch((@root_path + @face_root + 'integrations/step_definitions/then.rb').to_s)
    end
  end
end