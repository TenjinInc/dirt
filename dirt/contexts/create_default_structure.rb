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