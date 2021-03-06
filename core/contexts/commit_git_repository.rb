#--
# Copyright (c) 2014 Tenjin Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#++

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

      Dir.glob("#{@project_path}/**/*", File::FNM_DOTMATCH).select do |f|
        path = Pathname.new(f)
        path.file? && !path.to_s.include?('/.git/')
      end.each { |f| system(%Q{git --git-dir "#{@project_path}/.git" --work-tree "#{@project_path}" add -v "#{f}"}) }

      system(%Q{git --git-dir "#{@project_path}/.git" --work-tree "#{@project_path}" commit -am "Project init with Dirt."})

      system(%Q{git --git-dir "#{@project_path}/.git" --work-tree "#{@project_path}" push origin master})

      'Comitting and pushing...'
    end
  end
end


