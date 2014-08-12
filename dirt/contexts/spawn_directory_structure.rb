module Samling
  class SpawnDirectoryStructure < Dirt::Context
    def initialize(project_location, project_directory)
      @project_root, @project_directory = project_location, project_directory
    end

    def call
      project_root = Pathname.new(@project_root || '') + @project_directory

      FileUtils.mkdir_p(project_root)

      paths = ['config',
               'dirt/contexts',
               'dirt/contexts/roles',
               'dirt/models',
               'dirt/tests/behaviours',
               'dirt/tests/behaviours/support',
               'dirt/tests/behaviours/step_definitions',
               'dirt/tests/isolations',
               'faces']

      paths.each do |path|
        FileUtils.mkdir_p(File.expand_path(path, project_root))
      end
    end
  end
end