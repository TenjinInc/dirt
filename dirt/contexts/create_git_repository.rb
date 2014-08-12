module Samling
  class CreateGitRepository < Dirt::Context
    def initialize(project_path, bare_path, host, user, password)
      # @project_root_path = Pathname.new(project_root)
      # @project_directory = @project_root_path.basename
    end

    def call
# puts `git init --bare #{project_directory}.git`
# puts `git clone thor:/var/git/#{project_directory}.git`
    end
  end
end


