# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'taskmeister/version'

Gem::Specification.new do |spec|
  spec.name          = "taskmeister"
  spec.version       = Taskmeister::VERSION
  spec.authors       = ["Ray Grasso"]
  spec.email         = ["ray.grasso@gmail.com"]
  spec.summary       = %q{A simple command line task manager.}
  spec.description   = %q{Another command line task manager. You know, for the heck of it.}
  spec.homepage      = "https://www.github.com/grassdog/taskmeister"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
