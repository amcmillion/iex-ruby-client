require 'spec_helper'

describe CloudQuote::Api::Config::Client do
  before do
    CloudQuote::Api.config.reset!
  end
  describe '#defaults' do
    it 'sets endpoint' do
      expect(CloudQuote::Api.config.endpoint).to eq 'https://api.cloudquote.io'
    end
  end

  describe '#configure' do
    before do
      CloudQuote::Api.configure do |config|
        config.endpoint = 'updated'
      end
    end

    it 'sets endpoint' do
      expect(CloudQuote::Api.config.endpoint).to eq 'updated'
    end
  end

  context 'when configuring the logger' do
    after { CloudQuote::Api.configure.logger.reset! }

    let(:logger) { Logger.new(STDOUT) }

    describe '#logger=' do
      it 'updates CloudQuote::Api.config correctly' do
        expect do
          CloudQuote::Api.configure { |config| config.logger = logger }
        end.to change(CloudQuote::Api.config.logger, :instance).from(nil).to(logger)
      end

      it 'updates CloudQuote::Api.logger correctly' do
        expect do
          CloudQuote::Api.configure { |config| config.logger = logger }
        end.to change(CloudQuote::Api.logger, :instance).from(nil).to(logger)
      end
    end

    describe '#logger' do
      it 'accesses the current logger' do
        expect { CloudQuote::Api.logger = logger }
          .to change(CloudQuote::Api.config.logger, :instance).from(nil).to(logger)
      end
    end
  end
end
