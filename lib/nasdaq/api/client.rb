module Nasdaq
  module Api
    extend Config::Client::Accessor
    extend Config::Logger::Accessor

    class Client
      include Endpoints::ShortInterest

      include Nasdaq::Cloud::Connection
      include Nasdaq::Cloud::Request

      attr_accessor(*Config::Client::ATTRIBUTES)

      attr_reader :logger

      def initialize(options = {})
        Config::Client::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || Nasdaq::Api.config.send(key))
        end
        @logger = Config::Logger.dup
        @logger.instance = options[:logger] if options.key?(:logger)
      end
    end
  end
end
