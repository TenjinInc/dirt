module Samling
  class Generating < Dirt::Role
    def generate_templates(project_root)
      templates_dir = Pathname.new('config/templates/')
      project_name = project_root.basename.to_s

      @decorated.each do |f, t|
        file = project_root + f.gsub('project_name', project_name)

        FileUtils.mkdir_p(file.dirname)

        if t
          template_file = templates_dir + t

          file.open('w') do |file|
            content = template_file.read.gsub('<project_name>', project_name)

            file.write(content)
          end
        else
          FileUtils.touch(file.to_s)
        end
      end
    end
  end
end