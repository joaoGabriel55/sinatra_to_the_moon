# Sinatra to the Moon

`sinatra_to_the_moon` generates concise, modular, and testable Sinatra web applications, REST APIs, and GraphQL APIs. It provides the `flyme` command while keeping the generated code close to ordinary Sinatra.

## Installation

```sh
gem install sinatra_to_the_moon
```

## Generate an application

Create an MVC-style Sinatra web app with ERB views and Tailwind CSS:

```sh
flyme new moon_app
```

The web profile is the default. It uses the latest `tailwindcss-ruby` release, so no Node.js toolchain is required. Start its CSS watcher with:

```sh
cd moon_app
bundle exec rake assets:watch
```

Create a minimal API-shaped scaffold without views:

```sh
flyme new moon_service --minimal
```

Create a REST API:

```sh
flyme new moon_api --api
```

Create a GraphQL API:

```sh
flyme new moon_graph --graphql
```

The explicit profile form is also available:

```sh
flyme new moon_api --profile api
```

Preview files without writing them:

```sh
flyme new moon_app --dry-run
```

`flyme` refuses to write into an existing destination unless `--force` is passed.

After generation:

```sh
cd moon_app
bundle install
bundle exec rackup
```

Run the generated application checks with:

```sh
bundle exec rake
```

## Design

Generated projects use modules for stateless behavior. Classes are reserved for objects that retain state and framework contracts such as `Sinatra::Base` and `GraphQL::Schema`.

Profiles remain small:

- `web` is the default and provides MVC-style modules, ERB views, and Tailwind CSS.
- `minimal` provides a modular Sinatra app and health endpoint.
- `api` adds JSON request/response helpers and example REST routes.
- `graphql` adds a GraphQL schema and endpoint.

Every generated project includes request specs and RuboCop configuration.

The generator follows the same approach: Thor owns the stateful CLI class, while project validation, template rendering, and generation are organized as stateless modules. `why-classes` checks this convention during development.

## Development

Install dependencies and run every check:

```sh
bundle install
bundle exec rake
```

The default task runs RSpec, RuboCop, and `why-classes`.

Build the gem locally with:

```sh
gem build sinatra_to_the_moon.gemspec
```

Generator specs create every profile in a temporary directory, run its request specs, and lint the resulting application. Changes to CLI behavior or templates should include regression coverage.

See [AGENTS.md](AGENTS.md) for contributor conventions. AI-assisted work should also follow [CLAUDE.md](CLAUDE.md).
