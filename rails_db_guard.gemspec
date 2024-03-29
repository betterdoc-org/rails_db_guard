# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rails_db_guard/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_db_guard"
  spec.version       = RailsDbGuard::VERSION
  spec.authors       = ["BetterDoc GmbH"]
  spec.email         = ["pirates@betterdoc.org"]

  spec.summary       = "Prevents connecting to protected environments databases from other environments"
  spec.homepage      = "https://github.com/betterdoc-org/rails_db_guard"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 5"

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "climate_control", "~> 0.2.0"
  spec.add_development_dependency "minitest", "~> 5"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "rubocop", "~> 0.74"
end
