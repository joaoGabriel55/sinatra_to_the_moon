# frozen_string_literal: true

require "tmpdir"
require "open3"

RSpec.describe SinatraToTheMoon::Generator do
  around do |example|
    Dir.mktmpdir("flyme-spec") do |directory|
      @directory = directory
      example.run
    end
  end

  it "generates a minimal modular Sinatra application" do
    files = described_class.generate(name: "moon_app", profile: "minimal", destination: @directory)
    root = File.join(@directory, "moon_app")

    expect(files).to include("moon_app/app.rb", "moon_app/.rubocop.yml", "moon_app/spec/requests/health_spec.rb")
    expect(File.read(File.join(root, "app.rb"))).to include("class App < Sinatra::Base")
    expect(File.read(File.join(root, "app/routes/health.rb"))).to include("module Health")
    expect_ruby_files_to_be_valid(root)
  end

  it "generates an MVC web application with Tailwind CSS by default" do
    files = described_class.generate(name: "moon_web", destination: @directory)
    root = File.join(@directory, "moon_web")

    expect(files).to include(
      "moon_web/app/controllers/home.rb",
      "moon_web/app/models/page.rb",
      "moon_web/views/home.erb",
      "moon_web/assets/stylesheets/application.css"
    )
    expect(File.read(File.join(root, "Gemfile"))).to include('gem "tailwindcss-ruby"')
    expect(File.read(File.join(root, "Rakefile"))).to include("task :watch")
    expect_ruby_files_to_be_valid(root)
  end

  it "adds REST API files for the api profile" do
    described_class.generate(name: "moon_api", profile: "api", destination: @directory)
    root = File.join(@directory, "moon_api")

    expect(File).to exist(File.join(root, "app/http/json.rb"))
    expect(File).to exist(File.join(root, "app/routes/users.rb"))
    expect(File.read(File.join(root, "app.rb"))).to include("register Routes::Users")
    expect_ruby_files_to_be_valid(root)
  end

  it "adds a schema and endpoint for the graphql profile" do
    described_class.generate(name: "moon_graph", profile: "graphql", destination: @directory)
    root = File.join(@directory, "moon_graph")

    expect(File).to exist(File.join(root, "app/graphql/schema.rb"))
    expect(File).to exist(File.join(root, "app/routes/graphql.rb"))
    expect(File.read(File.join(root, "Gemfile"))).to include('gem "graphql"')
    expect_ruby_files_to_be_valid(root)
  end

  it "does not write during a dry run" do
    files = described_class.generate(name: "preview", destination: @directory, dry_run: true)

    expect(files).not_to be_empty
    expect(File).not_to exist(File.join(@directory, "preview"))
  end

  it "protects an existing destination" do
    Dir.mkdir(File.join(@directory, "existing"))

    expect { described_class.generate(name: "existing", destination: @directory) }
      .to raise_error(SinatraToTheMoon::DestinationExistsError, /--force/)
  end

  it "overwrites generated files when force is enabled" do
    root = File.join(@directory, "existing")
    Dir.mkdir(root)
    File.write(File.join(root, "app.rb"), "old content")

    described_class.generate(name: "existing", destination: @directory, force: true)

    expect(File.read(File.join(root, "app.rb"))).to include("class App < Sinatra::Base")
  end

  it "rejects unknown profiles" do
    expect { described_class.generate(name: "moon", profile: "spaceship", destination: @directory) }
      .to raise_error(SinatraToTheMoon::UnknownProfileError)
  end

  %w[web minimal api graphql].each do |profile|
    article = profile == "api" ? "an" : "a"

    it "generates #{article} #{profile} project whose specs and lint pass" do
      name = "#{profile}_app"
      described_class.generate(name: name, profile: profile, destination: @directory)

      output, status = run_generated_checks(File.join(@directory, name))

      expect(output).to include("0 failures")
      expect(status).to be_success, output
      expect(File).to be_exist(File.join(@directory, name, "public/application.css")) if profile == "web"
    end
  end

  def expect_ruby_files_to_be_valid(root)
    ruby_files = Dir.glob(File.join(root, "**", "{*.rb,config.ru,Rakefile}"))
    failures = ruby_files.reject { |file| system(RbConfig.ruby, "-c", file, out: File::NULL, err: File::NULL) }

    expect(failures).to be_empty
  end

  def run_generated_checks(root)
    environment = { "BUNDLE_GEMFILE" => File.expand_path("../Gemfile", __dir__) }
    stdout, stderr, status = Open3.capture3(environment, "bundle", "exec", "rake", chdir: root)
    [stdout + stderr, status]
  end
end
