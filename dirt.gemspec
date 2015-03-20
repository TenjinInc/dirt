src_dir = File.expand_path('../core', __FILE__)
$LOAD_PATH.unshift(src_dir) unless $LOAD_PATH.include?(src_dir)
require 'version'

Gem::Specification.new do |spec|
  spec.name          = 'dirt'
  spec.version       = Dirt::VERSION
  spec.authors       = ['Robin Miller']
  spec.email         = ['robin@tenjin.ca']
  spec.summary       = %q{DIRT: DCI Implementation in Ruby with TDD}
  spec.description   = %q{Make best practices easy. Come play in the Dirt.}
  spec.homepage      = 'http://www.tenjin.ca'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n").reject { |path| path =~ %r{^\.gitignore$|^.*\.gemspec$} }
  spec.bindir        = ['faces/cli/bin']
  spec.executables   = ['dirt']
  spec.require_paths = ['dirt']

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_runtime_dependency 'dirt-core', '~> 2.2.2'
  spec.add_runtime_dependency 'activesupport'

  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'cucumber'
  spec.add_development_dependency 'capybara'
  spec.add_development_dependency 'launchy'
  spec.add_development_dependency 'fakefs'
  spec.add_development_dependency 'aruba-doubles'
  spec.add_development_dependency 'factory_girl', '~> 4.0'
  spec.add_development_dependency 'parallel_tests'
end