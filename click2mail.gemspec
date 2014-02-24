# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'click2mail/version'

Gem::Specification.new do |spec|
  spec.name          = "click2mail"
  spec.version       = Click2mail::VERSION
  spec.authors       = ["Customer Lobby llc"]
  spec.email         = ["jvolz@customerlobby.com"]
  spec.summary       = %q{This gem is intended to support Click2Mail MOL: Pro Batch XML API and MOL: Pro API}
  spec.description   = %q{}
  spec.homepage      = "https://github.com/customerlobby/click2mail"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "byebug"

  spec.add_dependency "rest-client", "~> 1.6.7"
end
