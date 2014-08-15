module Samling
  class PopulateDefaultFiles < Dirt::Context
    def initialize(project_root)
      @project_root_path = Pathname.new(project_root)
      @project_directory = @project_root_path.basename
    end

    def call
      #   FileUtils.mkdir_p(project_root)

      files_to_templates = {'.gitignore' => 'template.gitignore',
                            'Gemfile' => 'template.Gemfile',
                            "dirt/#{@project_directory}.rb" => 'template.project_name.rb',
                            'dirt/tests/behaviours/support/env.rb' => 'template.env.rb'}

      files_to_templates.each do |f, t|
        file = Pathname.new(@project_root_path) + f

        FileUtils.mkdir_p(file.dirname)
        File.open(file.to_s, 'w') do |file|
          specified_content = File.read(Pathname.new('config/templates/' + t).to_s)
          specified_content.gsub!('<project_name>', @project_directory.to_s)

          file.write(specified_content)
        end
      end
    end
  end
end