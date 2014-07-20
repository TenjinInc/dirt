module Samling
  class SpawnDirectoryStructure < Dirt::Context
    def initialize(project_location, project_directory)
      @project_location, @project_directory = project_location, project_directory
    end

    def call
      project_root = File.expand_path(@project_directory, @project_location)

      # FileUtils.mkdir(project_root)

      FileUtils.mkdir(project_root)

      FileUtils.mkdir(File.expand_path('app/contexts', project_root))
    end
  end
end