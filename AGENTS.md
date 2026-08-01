# Repository Guidelines

## Project Structure & Module Organization

The gem entry point is `lib/sinatra_to_the_moon.rb`. Implementation lives under `lib/sinatra_to_the_moon/`: `cli.rb` handles Thor commands, `generator.rb` writes projects, and `project.rb` validates names and profiles. Keep stateless behavior in modules; introduce classes only for state or framework contracts such as Thor and Sinatra.

Generator assets are ERB templates in `lib/sinatra_to_the_moon/templates/`. Shared files belong in `base/`; profile overrides and additions belong in `web/`, `api/`, or `graphql/`. Tests live in `spec/`, with generator integration coverage in `spec/generator_spec.rb`. The installed command is `bin/flyme`, while packaging is defined by `sinatra_to_the_moon.gemspec`.

## Build, Test, and Development Commands

- `bundle install` installs development and integration-test dependencies.
- `bundle exec rake` runs the complete quality gate: RSpec, RuboCop, and `why-classes`.
- `bundle exec rspec` runs repository and generated-project specs.
- `bundle exec rubocop` checks Ruby style without modifying files.
- `bundle exec why-classes --no-rails lib spec` detects unnecessary classes.
- `gem build sinatra_to_the_moon.gemspec` builds the distributable gem.
- `ruby -Ilib bin/flyme new demo --dry-run` previews generator output locally.

## Coding Style & Naming Conventions

Use two-space indentation, frozen-string comments, double-quoted Ruby strings, and a 120-character line limit as configured in `.rubocop.yml`. Use `snake_case` for files and methods, `SinatraToTheMoon` for the gem namespace, and `CamelCase` for generated application constants. Prefer `module_function` for stateless operations. Do not apply `why-classes --fix-unsafe` automatically.

## Testing Guidelines

RSpec is required for behavioral changes. Name files `*_spec.rb` and organize examples around public behavior. Generator changes must cover file output, Ruby syntax, and the generated profile’s own RSpec and RuboCop tasks. Add regression coverage for CLI errors, path safety, and template rendering. There is no fixed coverage percentage; changed behavior must be meaningfully exercised.

## Commit & Pull Request Guidelines

History commonly uses concise imperative subjects with prefixes such as `build:`, `fix:`, `docs:`, and `lint:`. Follow that pattern, for example `feat: add web profile`.

Pull requests should explain the user-facing change, list verification commands, and link related issues. Include example `flyme` commands and generated output when templates or CLI behavior change. Screenshots are only needed for visual web-template changes. Keep dependency and lockfile updates in the same PR as the change requiring them.
