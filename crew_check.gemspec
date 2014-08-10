# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crew_check/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-crew-check"
  spec.version       = CrewCheck::VERSION
  spec.authors       = ["Dan Pickett"]
  spec.email         = ["dan.pickett@launchacademy.com"]
  spec.summary       = %q{Add authorized roles based on github team name}
  spec.description   = %q{Add authorized roles to omniauth payload based on github team name}
  spec.homepage      = "http://www.launchacademy.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_dependency "omniauth-github"
  spec.add_dependency "octokit"

  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "mocha"
  spec.add_development_dependency "rack-test"
end
