module Samling
  class SpawnDirectoryStructure < Dirt::Context

    def initialize(project_location, project_directory)
      @project_location, @project_directory = project_location, project_directory
    end

    def call
      FileUtils.mkdir(File.expand_path(project_directory, project_location))
    end
  end
end