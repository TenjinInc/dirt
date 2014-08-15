module Samling
  class CommitGitRepository < Dirt::Context
    def initialize(project_path)
      @project_path = Pathname.new(project_path)
    end

    def call
      empty_dirs = Dir["#{@project_path}/**/*"].select do |d|
        Dir.entries(d) == ['.', '..'] if File.directory?(d)
      end

      empty_dirs.each do |dir|
        path = Pathname.new(dir) + '.gitkeep'

        path.dirname.mkpath
        FileUtils.touch(path)
      end

      Dir["#{@project_path}/**/*"].each do |f|
        path = Pathname.new(f)

        if path.file?
          `git add "#{f}"`
        end
      end

      `git commit -am "Dirt project init"`

      `git push origin master`
    end
  end
end


