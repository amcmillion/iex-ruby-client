require 'spec_helper'

describe Nasdaq::Api::Config::Client do
  before do
    Nasdaq::Api.config.reset!
  end
  describe '#defaults' do
    it 'sets endpoint' do
      expect(Nasdaq::Api.config.endpoint).to eq 'https://api.nasdaq.com/api'
    end
  end

  describe '#configure' do
    before do
      Nasdaq::Api.configure do |config|
        config.endpoint = 'updated'
      end
    end

    it 'sets endpoint' do
      expect(Nasdaq::Api.config.endpoint).to eq 'updated'
    end
  end

  context 'when configuring the logger' do
    after { Nasdaq::Api.configure.logger.reset! }

    let(:logger) { Logger.new(STDOUT) }

    describe '#logger=' do
      it 'updates Nasdaq::Api.config correctly' do
        expect do
          Nasdaq::Api.configure { |config| config.logger = logger }
        end.to change(Nasdaq::Api.config.logger, :instance).from(nil).to(logger)
      end

      it 'updates Nasdaq::Api.logger correctly' do
        expect do
          Nasdaq::Api.configure { |config| config.logger = logger }
        end.to change(Nasdaq::Api.logger, :instance).from(nil).to(logger)
      end
    end

    describe '#logger' do
      it 'accesses the current logger' do
        expect { Nasdaq::Api.logger = logger }
          .to change(Nasdaq::Api.config.logger, :instance).from(nil).to(logger)
      end
    end
  end
end
