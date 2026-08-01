# frozen_string_literal: true

require "tmpdir"

RSpec.describe SinatraToTheMoon::CLI do
  around do |example|
    Dir.mktmpdir("flyme-cli-spec") do |directory|
      Dir.chdir(directory) { example.run }
    end
  end

  it "generates an application through the new command" do
    output = capture_stdout { described_class.start(%w[new apollo]) }

    expect(File).to exist("apollo/app.rb")
    expect(File).to exist("apollo/views/home.erb")
    expect(File.read("apollo/Gemfile")).to include('gem "tailwindcss-ruby"')
    expect(output).to include("created  apollo/app.rb")
    expect(output).to include("Ready for launch")
    expect(output).to include("bundle exec rake assets:build")
  end

  it "supports the minimal shortcut" do
    capture_stdout { described_class.start(["new", "apollo_minimal", "--minimal"]) }

    expect(File).not_to exist("apollo_minimal/views/home.erb")
    expect(File).to exist("apollo_minimal/app/routes/health.rb")
  end

  it "supports the api shortcut" do
    capture_stdout { described_class.start(["new", "apollo_api", "--api"]) }

    expect(File).to exist("apollo_api/app/routes/users.rb")
  end

  it "rejects conflicting shortcuts" do
    error = capture_stderr do
      expect { described_class.start(["new", "apollo", "--api", "--graphql"]) }
        .to raise_error(SystemExit) { |exit| expect(exit.status).to eq(1) }
    end

    expect(error).to include("Choose only one profile shortcut")
    expect(File).not_to exist("apollo")
  end

  def capture_stdout
    original_stdout = $stdout
    $stdout = StringIO.new
    yield
    $stdout.string
  ensure
    $stdout = original_stdout
  end

  def capture_stderr
    original_stderr = $stderr
    $stderr = StringIO.new
    yield
    $stderr.string
  ensure
    $stderr = original_stderr
  end
end
