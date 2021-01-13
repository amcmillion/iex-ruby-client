module CloudQuote
  module Endpoints
    module Guidance
      def guidance(start_date, end_date, options = {})
        raise ArgumentError, 'End date must be after start date' if end_date < start_date

        get(
          'benzinga/getGuidance.json',
          {
            T: publishable_token,
            date_from: start_date.strftime("%Y-%m-%d"),
            date_to: end_date.strftime("%Y-%m-%d")
          }.merge(options)
        )['rows'].map do |data|
          CloudQuote::Resources::Guidance.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise CloudQuote::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
