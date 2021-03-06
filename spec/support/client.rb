RSpec.shared_context 'client' do |opts|
  let(:iex_client) { IEX::Api::Client.new(opts || {}) }
  let(:cq_client) { CloudQuote::Api::Client.new(opts || {}) }
  let(:nasdaq_client) { Nasdaq::Api::Client.new(opts || {}) }

  before do
    CloudQuote::Api.config.reset!
    IEX::Api.config.reset!
    Nasdaq::Api.config.reset!
  end
end
