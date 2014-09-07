module Samling
  class Generating < Dirt::Role
    def generate_templates(generated_project_root)
      templates_dir = Dirt::PROJECT_ROOT + 'config/templates/'
      project_name = generated_project_root.basename.to_s

      @decorated.each do |f, t|
        file = generated_project_root + f.gsub('project_name', project_name)

        FileUtils.mkdir_p(file.dirname)

        if t
          template_file = templates_dir + t

          file.open('w') do |file|
            content = File.read(template_file.to_s).gsub('<project_name>', project_name)

            file.write(content)
          end
        else
          FileUtils.touch(file.to_s)
        end
      end
    end
  end
end