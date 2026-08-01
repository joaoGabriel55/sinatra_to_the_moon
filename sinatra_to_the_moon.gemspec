# frozen_string_literal: true

require_relative "lib/sinatra_to_the_moon/version"

Gem::Specification.new do |spec|
  spec.name = "sinatra_to_the_moon"
  spec.version = SinatraToTheMoon::VERSION
  spec.authors = ["joaoGabriel55"]
  spec.summary = "Generate concise, testable Sinatra applications"
  spec.description = "A small CLI for generating modular Sinatra web apps, REST APIs, and GraphQL APIs."
  spec.homepage = "https://github.com/joaoGabriel55/sinatra_to_the_moon"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata = {
    "homepage_uri" => spec.homepage,
    "source_code_uri" => spec.homepage,
    "changelog_uri" => "#{spec.homepage}/blob/main/CHANGELOG.md",
    "bug_tracker_uri" => "#{spec.homepage}/issues",
    "rubygems_mfa_required" => "true"
  }

  spec.files = Dir["CHANGELOG.md", "CODE_OF_CONDUCT.md", "LICENSE.txt", "README.md", "bin/*", "lib/**/*", "sig/*"]
  spec.bindir = "bin"
  spec.executables = ["flyme"]
  spec.require_paths = ["lib"]

  spec.add_dependency "thor", "~> 1.3"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "rubocop", "~> 1.75"
  spec.add_development_dependency "why-classes", "~> 0.2"
end
