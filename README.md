<img width="612" height="430" alt="sinatra_to_the_moon" src="https://github.com/user-attachments/assets/770bb782-1d0d-44e1-9700-3bc0cf0b0fde" />

# Sinatra to the Moon

Put on your headphones and let Frank Sinatra take you on a journey with the timeless classic *Fly Me to the Moon*. Inspired by the legendary singer, the Ruby gem **Sinatra** has long been the go-to choice for lightweight web applications. Now it has a companion: **Sinatra To The Moon**.

Built on top of Sinatra, **Sinatra To The Moon** is an opinionated scaffold generator that embraces the philosophy that not every project needs the weight of Rails. Sometimes, all you need is a focused starting point that lets you build quickly, experiment freely, and, as the song says, *play among the stars*.

This gem generates concise, modular, and testable Sinatra web applications, REST APIs, and GraphQL APIs through the `flyme` command. It is not a runtime framework: generated applications use ordinary Sinatra and remain independent of `sinatra_to_the_moon` after generation.

## Successor to Sinatra Scaffold

This project is the new version of [`sinatra-scaffold`](https://rubygems.org/gems/sinatra-scaffold). It continues the original scaffold generator under a new gem name and adds the `flyme` CLI, modular project profiles, generated-project testing, GraphQL support, and a default MVC-style web application with Tailwind CSS.

Existing users should install `sinatra_to_the_moon` for future updates. The original `sinatra-scaffold` gem remains available for projects that depend on the 0.1.x releases.

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
