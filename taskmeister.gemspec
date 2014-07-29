# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'taskmeister/version'

Gem::Specification.new do |spec|
  spec.name          = "taskmeister"
  spec.version       = Taskmeister::VERSION
  spec.authors       = ["Ray Grasso"]
  spec.email         = ["ray.grasso@gmail.com"]
  spec.summary       = %q{Another command line task manager.}
  spec.description   = %q{Another command line task manager. You know, because I'm special.}
  spec.homepage      = "https://www.github.com/grassdog/taskmeister"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry-byebug", "~> 1.3"
end
