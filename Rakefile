# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new(:rubocop)

task default: %i[spec rubocop why_classes]

desc "Check that every class has a reason to exist"
task :why_classes do
  sh "why-classes", "--no-rails", "lib", "spec"
end
