# frozen_string_literal: true

module SinatraToTheMoon
  module Project
    NAME_PATTERN = /\A[a-z][a-z0-9_-]*\z/
    PROFILES = %w[web minimal api graphql].freeze

    module_function

    def validate_name!(name)
      return name if NAME_PATTERN.match?(name)

      raise InvalidProjectNameError,
            "Project name must start with a lowercase letter and contain only " \
            "lowercase letters, numbers, dashes, or underscores"
    end

    def validate_profile!(profile)
      return profile if PROFILES.include?(profile)

      raise UnknownProfileError, "Unknown profile #{profile.inspect}. Choose: #{PROFILES.join(', ')}"
    end

    def constant_name(name)
      name.split(/[-_]/).map(&:capitalize).join
    end
  end
end
