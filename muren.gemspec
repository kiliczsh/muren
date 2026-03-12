# frozen_string_literal: true

version = File.read(File.expand_path('VERSION', __dir__)).strip

Gem::Specification.new 'muren', version do |s|
  s.description       = 'Muren is a DSL for quickly creating web applications in Ruby with minimal effort.'
  s.summary           = 'Classy web-development dressed in a DSL'
  s.authors           = ['Blake Mizerany', 'Ryan Tomayko', 'Simon Rozet', 'Konstantin Haase']
  s.email             = 'murenrb@googlegroups.com'
  s.homepage          = 'http://murenrb.com/'
  s.license           = 'MIT'
  s.files             = Dir['README*.md', 'lib/**/*', 'examples/*'] + [
    '.yardopts',
    'AUTHORS.md',
    'CHANGELOG.md',
    'CONTRIBUTING.md',
    'Gemfile',
    'LICENSE',
    'MAINTENANCE.md',
    'Rakefile',
    'SECURITY.md',
    'muren.gemspec',
    'VERSION'
  ]
  s.extra_rdoc_files  = %w[README.md LICENSE]
  s.rdoc_options      = %w[--line-numbers --title Muren --main README.rdoc --encoding=UTF-8]

  unless s.respond_to?(:metadata)
    raise <<-WARN
RubyGems 2.0 or newer is required to protect against public gem pushes. You can update your rubygems version by running:
  gem install rubygems-update
  update_rubygems:
  gem update --system
    WARN
  end

  s.metadata = {
    'source_code_uri' => 'https://github.com/muren/muren',
    'changelog_uri' => 'https://github.com/muren/muren/blob/main/CHANGELOG.md',
    'homepage_uri' => 'http://murenrb.com/',
    'bug_tracker_uri' => 'https://github.com/muren/muren/issues',
    'mailing_list_uri' => 'http://groups.google.com/group/murenrb',
    'documentation_uri' => 'https://www.rubydoc.info/gems/muren',
    'rubygems_mfa_required' => 'true'
  }

  s.required_ruby_version = '>= 2.7.8'

  s.add_dependency 'logger', '>= 1.6.0'
  s.add_dependency 'mustermann', '~> 3.0'
  s.add_dependency 'rack', '>= 3.0.0', '< 4'
  s.add_dependency 'rack-protection', version
  s.add_dependency 'rack-session', '>= 2.0.0', '< 3'
  s.add_dependency 'tilt', '~> 2.0'
end
