# Claude Repository Instructions

@AGENTS.md

## Working Agreements

- Treat `AGENTS.md` as the canonical contributor guide; update it instead of duplicating shared instructions here.
- Preserve the public gem name `sinatra_to_the_moon`, Ruby namespace `SinatraToTheMoon`, and CLI command `flyme`.
- Prefer modules and `module_function` for stateless behavior. Add a class only when it retains state or satisfies a framework contract.
- Keep generator behavior in `lib/sinatra_to_the_moon/` and generated assets in the appropriate `templates/base`, `templates/web`, `templates/api`, or `templates/graphql` directory.
- Add or update specs for every behavioral change. Generator changes must verify the generated project, not only template text.
- Run `bundle exec rake` before considering work complete. This executes RSpec, RuboCop, and `why-classes`.
- Do not run `why-classes --fix-unsafe` automatically. Review its recommendations and refactor intentionally.
- Never overwrite an existing generated project unless the caller explicitly passes `--force`.
