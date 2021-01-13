require 'vcr'
require 'webmock/rspec'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures'
  config.hook_into :webmock
  # config.default_cassette_options = { record: :new_episodes }
  config.configure_rspec_metadata!

  config.filter_sensitive_data('test-iex-api-publishable-token') { ENV['IEX_API_PUBLISHABLE_TOKEN'] }
  config.filter_sensitive_data('test-iex-api-secret-token') { ENV['IEX_API_SECRET_TOKEN'] }
  config.filter_sensitive_data('test-cloud-quote-api-publishable-token') { ENV['CLOUD_QUOTE_API_PUBLISHABLE_TOKEN'] }
  config.filter_sensitive_data('test-cloud-quote-api-secret-token') { ENV['CLOUD_QUOTE_API_SECRET_TOKEN'] }
end
