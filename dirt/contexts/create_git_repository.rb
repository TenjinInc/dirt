module Samling
  class CreateGitRepository < Dirt::Context
    def initialize(project_path, bare_path, host, user, password)
      @project_path = Pathname.new(project_path)
      @bare_path = Pathname.new(bare_path)

      @bare_path = Pathname.new(@bare_path.to_s + '.git') if @bare_path.extname.blank?

      # @project_root_path = Pathname.new(project_root)
      # @project_directory = @project_root_path.basename
    end

    def call
      `git init --bare #{@bare_path}`
      `git clone #{@bare_path} #{@project_path}`
    end
  end
end


