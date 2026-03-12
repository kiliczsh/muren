# Müren::Contrib

Collection of common Müren extensions, semi-officially supported.

## Goals

* For every future Müren release, have at least one fully compatible release
* High code quality, high test coverage
* Include plugins people usually ask for a lot

## Included extensions

### Common Extensions

These are common extension which will not add significant overhead or change any
behavior of already existing APIs. They do not add any dependencies not already
installed with this gem.

Currently included:

* [`muren/capture`][muren-capture]: Let's you capture the content of blocks in templates.

* [`muren/config_file`][muren-config-file]: Allows loading configuration from yaml files.

* [`muren/content_for`][muren-content-for]: Adds Rails-style `content_for` helpers to Haml, Erb, Erubi
  and Slim.

* [`muren/cookies`][muren-cookies]: A `cookies` helper for reading and writing cookies.

* [`muren/engine_tracking`][muren-engine-tracking]: Adds methods like `haml?` that allow helper
  methods to check whether they are called from within a template.

* [`muren/json`][muren-json]: Adds a `#json` helper method to return JSON documents.

* [`muren/link_header`][muren-link-header]: Helpers for generating `link` HTML tags and
  corresponding `Link` HTTP headers. Adds `link`, `stylesheet` and `prefetch`
  helper methods.

* [`muren/multi_route`][muren-multi-route]: Adds ability to define one route block for multiple
  routes and multiple or custom HTTP verbs.

* [`muren/namespace`][muren-namespace]: Adds namespace support to Müren.

* [`muren/respond_with`][muren-respond-with]: Choose action and/or template automatically
  depending on the incoming request. Adds helpers `respond_to` and
  `respond_with`.

* [`muren/custom_logger`][muren-custom-logger]: This extension allows you to define your own
  logger instance using +logger+ setting. That logger then will
  be available as #logger helper method in your routes and views.

* [`muren/required_params`][muren-required-params]: Ensure if required query parameters exist

### Custom Extensions

These extensions may add additional dependencies and enhance the behavior of the
existing APIs.

Currently included:

* [`muren/reloader`][muren-reloader]: Automatically reloads Ruby files on code changes. **DEPRECATED**: Please consider
consider using an alternative like [rerun](https://github.com/alexch/rerun) or
[rack-unreloader](https://github.com/jeremyevans/rack-unreloader) instead.

### Other Tools

* [`muren/extension`][muren-extension]: Mixin for writing your own Müren extensions.

* [`muren/test_helpers`][muren-test-helpers]: Helper methods to ease testing your Müren
  application. Partly extracted from Müren. Testing framework agnostic

* `muren/quiet_logger`: Extension to exclude specific paths from access log.
  It works by patching Rack::CommonLogger

## Installation

Add `gem 'muren-contrib'` to *Gemfile*, then execute `bundle install`.

If you don't use Bundler, install the gem manually by executing `gem install muren-contrib` in your command line.

### Git

If you want to use the gem from git, for whatever reason, you can do the following:

```ruby
github 'muren/muren' do
  gem 'muren-contrib'
end
```

Within this block you can also specify other gems from this git repository.

## Usage

### Classic Style

A single extension (example: muren-content-for):

``` ruby
require 'muren'
require 'muren/content_for'
```

Common extensions:

``` ruby
require 'muren'
require 'muren/contrib'
```

All extensions:

``` ruby
require 'muren'
require 'muren/contrib/all'
```

### Modular Style

A single extension (example: muren-content-for):

``` ruby
require 'muren/base'
require 'muren/content_for'
require 'muren/namespace'

class MyApp < Müren::Base
  # Note: Some modules are extensions, some helpers, see the specific
  # documentation or the source
  helpers Müren::ContentFor
  register Müren::Namespace
end
```

Common extensions:

``` ruby
require 'muren/base'
require 'muren/contrib'

class MyApp < Müren::Base
  register Müren::Contrib
end
```

All extensions:

``` ruby
require 'muren/base'
require 'muren/contrib/all'

class MyApp < Müren::Base
  register Müren::Contrib
end
```

### Documentation

For more info check the [official docs](http://www.murenrb.com/contrib/) and
[api docs](https://www.rubydoc.info/gems/muren-contrib).

[muren-reloader]: http://www.murenrb.com/contrib/reloader
[muren-namespace]: http://www.murenrb.com/contrib/namespace
[muren-content-for]: http://www.murenrb.com/contrib/content_for
[muren-cookies]: http://www.murenrb.com/contrib/cookies
[muren-streaming]: http://www.murenrb.com/contrib/streaming
[muren-webdav]: http://www.murenrb.com/contrib/webdav
[muren-runner]: http://www.murenrb.com/contrib/runner
[muren-extension]: http://www.murenrb.com/contrib/extension
[muren-test-helpers]: https://github.com/muren/muren/blob/main/muren-contrib/lib/muren/test_helpers.rb
[muren-required-params]: http://www.murenrb.com/contrib/required_params
[muren-custom-logger]: http://www.murenrb.com/contrib/custom_logger
[muren-multi-route]: http://www.murenrb.com/contrib/multi_route
[muren-json]: http://www.murenrb.com/contrib/json
[muren-respond-with]: http://www.murenrb.com/contrib/respond_with
[muren-config-file]: http://www.murenrb.com/contrib/config_file
[muren-link-header]: http://www.murenrb.com/contrib/link_header
[muren-capture]: http://www.murenrb.com/contrib/capture
[muren-engine-tracking]: https://github.com/muren/muren/blob/main/muren-contrib/lib/muren/engine_tracking.rb

