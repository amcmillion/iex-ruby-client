$LOAD_PATH.push File.expand_path('lib', __dir__)
require 'iex/version'

Gem::Specification.new do |s|
  s.name = 'vendor-api-clients'
  s.bindir = 'bin'
  s.version = IEX::VERSION
  s.authors = ['Andrew McMillion']
  s.email = 'andrewmcmillion90@gmail.com'
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = '>= 1.3.6'
  s.required_ruby_version = '>= 2.3.0'
  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.require_paths = ['lib']
  s.homepage = 'http://github.com/amcmillion/vendor-api-clients'
  s.licenses = ['MIT']
  s.summary = 'IEX, CloudQuote, and NASDAQ Finance API Ruby clients with support for retrieving stock quotes and trading data.'
  s.add_dependency 'faraday', '>= 0.17'
  s.add_dependency 'faraday_middleware'
  s.add_dependency 'hashie'
  s.add_dependency 'money_helper'
  s.add_development_dependency 'rake', '~> 10'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop', '0.72.0'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'
end
