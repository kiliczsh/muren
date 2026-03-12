# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Setup
```bash
bundle install
```

> Note: `Gemfile` pins `rubocop '~> 1.32.0'` which may conflict with newer local installations. Remove the version constraint if `bundle install` fails.

### Running tests
```bash
# All tests
bundle exec rake test

# Core muren tests only
bundle exec rake test:core

# Single test file
bundle exec ruby -Ilib -Itest test/routing_test.rb

# Single test by name
bundle exec ruby -Ilib -Itest test/routing_test.rb -n test_name

# With coverage
bundle exec rake test:coverage
```

### Linting
```bash
bundle exec rubocop
```

### Documentation
```bash
bundle exec rake doc  # Generates YARD docs in doc/api/
```

## Architecture

This is a **monorepo** containing three gems versioned together (version in `VERSION` file):

- **`muren`** (`lib/`) — core framework
- **`muren-contrib`** (`muren-contrib/`) — official extensions
- **`rack-protection`** (`rack-protection/`) — security middleware

### Core (`lib/muren/base.rb`)

The entire Müren framework lives in this single ~2200 line file. Key classes:

- `Müren::Base` — the main app class; all route DSL, settings, middleware stack, and request dispatch lives here. Subclass this for modular apps.
- `Müren::Application < Base` — the default application for classic-style (top-level DSL) apps.
- `Müren::Delegator` — delegates top-level method calls (`get`, `post`, `set`, etc.) to `Müren::Application`, enabling the classic `require 'muren'` style.
- `Müren::Request < Rack::Request` — extends Rack request with content negotiation (`accept`, `preferred_type`).
- `Müren::Response < Rack::Response` — extends Rack response.
- `Müren::Helpers` — mixed into every request context; provides `halt`, `pass`, `redirect`, `send_file`, `content_type`, etc.
- `Müren::Templates` — mixed into `Base`; handles rendering via Tilt (ERB, Haml, Slim, etc.).

**Two usage modes:**
1. **Classic** (`require 'muren'`) — routes defined at top level via `Delegator`, all state in `Müren::Application`.
2. **Modular** (`require 'muren/base'`) — subclass `Müren::Base` explicitly; must call `run!` or mount via Rack.

**Route dispatch flow:** `Base.call` → `Base#call!` → `dispatch!` → matches routes via Mustermann patterns → executes filters (before/after) → calls route block in app instance context.

**Middleware stack** is built lazily via `Rack::Builder` in `Base.build`. Default middleware includes: `ExtendedRack`, `ShowExceptions` (dev), `Rack::MethodOverride`, `Rack::Head`, logging, sessions, `rack-protection`.

**Settings** use class-level `set :name, value` which defines getter/setter methods on the class. Settings are inherited by subclasses.

### muren-contrib (`muren-contrib/lib/muren/`)

Extensions split into two categories (see `contrib.rb`):
- **`Common`** — auto-loaded with `require 'muren/contrib'`: `config_file`, `multi_route`, `namespace`, `respond_with`, and helpers (`cookies`, `json`, `streaming`, `content_for`, etc.)
- **`Custom`** — must be required explicitly: `reloader`, `haml_helpers`

Extensions use `Müren::Extension` pattern: `register` adds class-level DSL, `helpers` adds instance-level methods.

### rack-protection (`rack-protection/lib/rack/protection/`)

Standalone Rack middleware, each in its own file. `Base` class provides shared config. Auto-included by Müren unless `protect: false`. Covers CSRF (`authenticity_token`, `form_token`), XSS headers, session hijacking, IP spoofing, path traversal, frame options, CSP, etc.

### Tests (`test/`)

Uses **Minitest** with `rack-test` for HTTP simulation. `test/contest.rb` adds `context`/`setup`/`teardown` DSL. `test/test_helper.rb` provides `mock_app` helper that creates an anonymous `Müren::Base` subclass inline — the standard pattern for unit tests. Integration tests in `test/integration/` spin up real servers.
