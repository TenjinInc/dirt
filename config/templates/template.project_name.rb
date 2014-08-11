require 'pathname'
require 'dirt'

app_dir = Pathname.new(__FILE__).dirname

# require ALL the files!
Dir["#{app_dir}/**/*.rb"].reject { |f| f.include?('/faces/') || f.include?('/tests/') }.each do |file|
  require file
end