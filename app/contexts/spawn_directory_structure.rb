module Samling
  class SpawnDirectoryStructure < Dirt::Context
    def initialize(project_location, project_directory)
      @project_location, @project_directory = project_location, project_directory
    end

    def call
      project_root = @project_location + '/' + @project_directory

      FileUtils.mkdir_p(project_root)

      paths = ['app/contexts/roles',
               'app/faces',
               'app/models',
               'config',
               'test/behaviours/step_definitions',
               'test/behaviours/support',
               'test/factories/',
               'test/integrations/step_definitions',
               'test/integrations/support']

      paths.each do |path|
        FileUtils.mkdir_p(File.expand_path(path, project_root))
      end
    end
  end
end