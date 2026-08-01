# frozen_string_literal: true

require "fileutils"

require "sinatra_to_the_moon/error"
require "sinatra_to_the_moon/project"
require "sinatra_to_the_moon/templates"

module SinatraToTheMoon
  module Generator
    module_function

    def generate(name:, profile: "web", destination: Dir.pwd, force: false, dry_run: false)
      Project.validate_name!(name)
      Project.validate_profile!(profile)

      target = File.expand_path(name, destination)
      ensure_destination_available!(target, force: force)

      locals = { app_name: name, constant_name: Project.constant_name(name), profile: profile }
      files = Templates.files_for(profile)

      files.each do |relative_path, template|
        path = File.join(target, relative_path)
        next if dry_run

        FileUtils.mkdir_p(File.dirname(path))
        File.write(path, Templates.render(template, locals))
      end

      files.keys.map { |path| File.join(name, path) }
    end

    def ensure_destination_available!(target, force:)
      return unless File.exist?(target)
      return if force

      raise DestinationExistsError, "Destination already exists: #{target}. Pass --force to overwrite generated files"
    end
  end
end
