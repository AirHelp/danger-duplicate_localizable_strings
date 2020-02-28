# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'duplicate_localizable_strings/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'danger-duplicate_localizable_strings'
  spec.version       = DuplicateLocalizableStrings::VERSION
  spec.authors       = ['AirHelp']
  spec.email         = ['ah-mobile@airhelp.com']
  spec.description   = %q{A danger plugin for checking detecting duplicates in Localizable.strings files.}
  spec.summary       = %q{A danger plugin for checking detecting duplicates in Localizable.strings files.}
  spec.homepage      = 'https://github.com/AirHelp/danger-duplicate_localizable_strings'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'danger', '~> 6.0'

  # General ruby development
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'

  # Testing support
  spec.add_development_dependency 'rspec', '~> 3.8'

  # Linting code and docs
  spec.add_development_dependency "rubocop", "~> 0.68"
  spec.add_development_dependency "yard", "~> 0.9"

  # Makes testing easy via `bundle exec guard`
  spec.add_development_dependency 'guard', '~> 2.15'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'

  # If you want to work on older builds of ruby
  spec.add_development_dependency 'listen', '3.1.5'

  # This gives you the chance to run a REPL inside your test
  # via
  #    require 'pry'
  #    binding.pry
  # This will stop test execution and let you inspect the results
  spec.add_development_dependency 'pry'
end
