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
  class CreateGitRepository < Dirt::Context
    def initialize(project_path, bare_parent_path, host, user)
      @project_path = Pathname.new(project_path)
      @bare_path = Pathname.new(bare_parent_path) + (@project_path.basename.to_s + '.git')
      @host = host
      @user = user
    end

    def call
      if @host.blank?
        `git init --bare #{@bare_path}`
        `git clone #{@bare_path} #{@project_path}`
      else
        `ssh #{@user}@#{@host} "git init --bare #{@bare_path}"`
        `git clone #{@user}@#{@host}:#{@bare_path} #{@project_path}`
      end
    end
  end
end


