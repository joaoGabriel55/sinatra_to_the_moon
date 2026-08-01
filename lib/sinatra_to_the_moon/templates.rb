# frozen_string_literal: true

require "erb"

module SinatraToTheMoon
  module Templates
    ROOT = File.expand_path("templates", __dir__)

    module_function

    def files_for(profile)
      template_files("base")
        .merge(template_files(profile))
        .transform_keys { |path| path.delete_suffix(".tt") }
    end

    def render(template, locals)
      ERB.new(File.read(template), trim_mode: "-").result_with_hash(**locals)
    end

    def template_files(directory)
      root = File.join(ROOT, directory)
      return {} unless Dir.exist?(root)

      Dir.glob(File.join(root, "**", "*.tt"), File::FNM_DOTMATCH).sort.to_h do |file|
        [file.delete_prefix("#{root}/"), file]
      end
    end
  end
end
