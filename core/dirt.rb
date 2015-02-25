require 'pathname'
require 'dirt/core'
require 'active_support'

app_dir = Pathname.new(__FILE__).dirname

# require ALL the files!
Dir["#{app_dir}/**/*.rb"].reject { |f| f.include?('/faces/') || f.include?('/tests/') }.each do |file|
  require file
end

module Dirt
  PROJECT_ROOT = Pathname.new(File.dirname(__FILE__) + '/..').realpath
end