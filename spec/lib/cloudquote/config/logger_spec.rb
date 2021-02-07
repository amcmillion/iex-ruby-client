require 'spec_helper'

describe CloudQuote::Api::Config::Logger do
  after { CloudQuote::Api.logger.reset! }

  describe '#defaults' do
    it 'sets the default values' do
      expect(CloudQuote::Api.logger.instance).to be_nil
      expect(CloudQuote::Api.logger.options).to eq({})
      expect(CloudQuote::Api.logger.proc).to be_nil
    end
  end

  describe '#logger' do
    let(:logger_instance) { Logger.new(STDOUT) }
    let(:opts) { { bodies: true } }
    let(:proc_arg) { proc {} }

    it 'allows setting the instance directly' do
      expect { CloudQuote::Api.logger = logger_instance }
        .to change(CloudQuote::Api::Config::Logger, :instance).to(logger_instance)
    end

    context 'when configuing' do
      after do
        expect(CloudQuote::Api.logger.instance).to eq(logger_instance)
        expect(CloudQuote::Api.logger.options).to eq(opts)
        expect(CloudQuote::Api.logger.proc).to eq(proc_arg)
      end

      it 'sets via assignment' do
        CloudQuote::Api.logger.instance = logger_instance
        CloudQuote::Api.logger.options = opts
        CloudQuote::Api.logger.proc = proc_arg
      end

      it 'sets via block' do
        CloudQuote::Api.logger do |logger|
          logger.instance = logger_instance
          logger.options = opts
          logger.proc = proc_arg
        end
      end
    end
  end
end
