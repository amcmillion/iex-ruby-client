module CloudQuote
  module Api
    extend Config::Client::Accessor
    extend Config::Logger::Accessor

    class Client
      include Endpoints::Guidance

      include Cloud::Connection
      include Cloud::Request

      attr_accessor(*Config::Client::ATTRIBUTES)

      attr_reader :logger

      def initialize(options = {})
        Config::Client::ATTRIBUTES.each do |key|
          send("#{key}=", options[key] || CloudQuote::Api.config.send(key))
        end
        @logger = Config::Logger.dup
        @logger.instance = options[:logger] if options.key?(:logger)
      end
    end
  end
end
