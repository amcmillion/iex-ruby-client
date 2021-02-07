require 'spec_helper'

describe Nasdaq::Api::Config::Logger do
  after { Nasdaq::Api.logger.reset! }

  describe '#defaults' do
    it 'sets the default values' do
      expect(Nasdaq::Api.logger.instance).to be_nil
      expect(Nasdaq::Api.logger.options).to eq({})
      expect(Nasdaq::Api.logger.proc).to be_nil
    end
  end

  describe '#logger' do
    let(:logger_instance) { Logger.new(STDOUT) }
    let(:opts) { { bodies: true } }
    let(:proc_arg) { proc {} }

    it 'allows setting the instance directly' do
      expect { Nasdaq::Api.logger = logger_instance }
        .to change(Nasdaq::Api::Config::Logger, :instance).to(logger_instance)
    end

    context 'when configuing' do
      after do
        expect(Nasdaq::Api.logger.instance).to eq(logger_instance)
        expect(Nasdaq::Api.logger.options).to eq(opts)
        expect(Nasdaq::Api.logger.proc).to eq(proc_arg)
      end

      it 'sets via assignment' do
        Nasdaq::Api.logger.instance = logger_instance
        Nasdaq::Api.logger.options = opts
        Nasdaq::Api.logger.proc = proc_arg
      end

      it 'sets via block' do
        Nasdaq::Api.logger do |logger|
          logger.instance = logger_instance
          logger.options = opts
          logger.proc = proc_arg
        end
      end
    end
  end
end
