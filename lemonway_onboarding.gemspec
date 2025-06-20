# frozen_string_literal: true

require_relative 'lib/lemonway_onboarding/version'

Gem::Specification.new do |spec|
  spec.name = 'lemonway_onboarding'
  spec.version = LemonwayOnboarding::VERSION
  spec.authors = ['Fabrice Carrega']
  spec.email = ['contact@treize37.com']

  spec.summary = 'Ruby wrapper for the Lemonway Onboarding API.'
  spec.description = 'A Ruby client for the Lemonway Onboarding API, ' \
    'providing an easy way to interact with the API for onboarding users and managing their accounts.'
  spec.homepage = 'https://github.com/treize37/lemonway_onboarding'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/Treize37/lemonway_onboarding/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'typhoeus', '>= 1.4'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
