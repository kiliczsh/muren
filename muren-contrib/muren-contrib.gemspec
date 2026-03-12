# frozen_string_literal: true

require_relative 'lib/muren/contrib/version'

version = Muren::Contrib::VERSION

Gem::Specification.new do |s|
  s.name        = 'muren-contrib'
  s.version     = version
  s.description = 'Collection of useful Muren extensions'
  s.homepage    = 'http://murenrb.com/contrib/'
  s.license     = 'MIT'
  s.summary     = "#{s.description}."
  s.authors     = ['https://github.com/muren/muren/graphs/contributors']
  s.email       = 'murenrb@googlegroups.com'
  s.files       = Dir['lib/**/*.rb'] + [
    'LICENSE',
    'README.md',
    'Rakefile',
    'ideas.md',
    'muren-contrib.gemspec'
  ]

  unless s.respond_to?(:metadata)
    raise <<-WARN
RubyGems 2.0 or newer is required to protect against public gem pushes. You can update your rubygems version by running:
  gem install rubygems-update
  update_rubygems:
  gem update --system
    WARN
  end

  s.metadata = {
    'source_code_uri' => 'https://github.com/muren/muren/tree/main/muren-contrib',
    'homepage_uri' => 'http://murenrb.com/contrib/',
    'documentation_uri' => 'https://www.rubydoc.info/gems/muren-contrib',
    'rubygems_mfa_required' => 'true'
  }

  s.required_ruby_version = '>= 2.7.8'

  s.add_dependency 'multi_json', '>= 0.0.2'
  s.add_dependency 'mustermann', '~> 3.0'
  s.add_dependency 'rack-protection', version
  s.add_dependency 'muren', version
  s.add_dependency 'tilt', '~> 2.0'
end
