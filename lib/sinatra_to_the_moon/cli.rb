# frozen_string_literal: true

require "thor"
require "sinatra_to_the_moon/error"
require "sinatra_to_the_moon/generator"
require "sinatra_to_the_moon/version"

module SinatraToTheMoon
  class CLI < Thor
    package_name "flyme"

    def self.exit_on_failure?
      true
    end

    desc "new APP_NAME", "Create a concise, testable Sinatra application"
    method_option :profile,
                  aliases: "-p",
                  default: "web",
                  enum: Project::PROFILES,
                  desc: "Application profile"
    method_option :web, type: :boolean, default: false, desc: "Shortcut for --profile web"
    method_option :minimal, type: :boolean, default: false, desc: "Shortcut for --profile minimal"
    method_option :api, type: :boolean, default: false, desc: "Shortcut for --profile api"
    method_option :graphql, type: :boolean, default: false, desc: "Shortcut for --profile graphql"
    method_option :force, type: :boolean, default: false, desc: "Overwrite generated files"
    method_option :dry_run, type: :boolean, default: false, desc: "Print files without writing them"
    def new(app_name)
      profile = selected_profile
      files = Generator.generate(
        name: app_name,
        profile: profile,
        force: options[:force],
        dry_run: options[:dry_run]
      )

      action = options[:dry_run] ? "would create" : "created"
      files.each { |file| say("#{action}  #{file}", :green) }
      say "\nReady for launch: #{launch_command(app_name, profile)}"
    rescue Error => e
      raise Thor::Error, e.message
    end

    desc "version", "Print the flyme version"
    def version
      say SinatraToTheMoon::VERSION
    end

    map %w[-v --version] => :version

    private

    def selected_profile
      shortcuts = selected_shortcuts
      raise Thor::Error, "Choose only one profile shortcut" if shortcuts.length > 1
      if shortcuts.any? && options[:profile] != "web"
        raise Thor::Error,
              "Use either --profile or a profile shortcut"
      end

      shortcuts.first || options[:profile]
    end

    def selected_shortcuts
      Project::PROFILES.select { |profile| options[profile.to_sym] }
    end

    def launch_command(app_name, profile)
      commands = ["cd #{app_name}", "bundle install"]
      commands << "bundle exec rake assets:build" if profile == "web"
      commands << "bundle exec rackup"
      commands.join(" && ")
    end
  end
end
