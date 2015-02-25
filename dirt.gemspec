src_dir = File.expand_path('../core', __FILE__)
$LOAD_PATH.unshift(src_dir) unless $LOAD_PATH.include?(src_dir)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = 'dirt'
  spec.version       = Dirt::VERSION
  spec.authors       = ['Robin Miller']
  spec.email         = ['robin@tenjin.ca']
  spec.summary       = %q{DIRT: DCI Implementation in Ruby with TDD}
  spec.description   = %q{Start your projects right with a strong, well-organised directory structure.}
  spec.homepage      = 'http://www.tenjin.ca'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n").reject { |path| path =~ %r{^\.gitignore$|^.*\.gemspec$} }
  spec.bindir        = ['faces/cli/bin']
  spec.executables   = ['dirt']
  spec.require_paths = ['dirt']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'dirt-core', '~> 2.2.2'
end