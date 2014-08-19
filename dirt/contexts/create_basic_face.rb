module Samling
  class CreateBasicFace < Dirt::Context
    def initialize(root_path, face_name)
      @root_path = Pathname.new(root_path)
      @face_root = @root_path + 'faces' + face_name
    end

    def call
      dirs = %w{integrations/support
                integrations/step_definitions}

      dirs.each do |f|
        FileUtils.mkdir_p(@face_root + f)
      end

      files_to_templates = {'integrations/support/env.rb' => 'template.env.rb'}

      files_to_templates.each do |f, t|
        File.open((@face_root + f).to_s, 'w') do |file|
          specified_content = File.read(Pathname.new('config/templates/' + t).to_s)
          specified_content.gsub!('<project_name>', @root_path.basename.to_s)

          file.write(specified_content)
        end
      end

      FileUtils.touch((@face_root + 'integrations/step_definitions/given.rb').to_s)
      FileUtils.touch((@face_root + 'integrations/step_definitions/when.rb').to_s)
      FileUtils.touch((@face_root + 'integrations/step_definitions/then.rb').to_s)
    end
  end
end