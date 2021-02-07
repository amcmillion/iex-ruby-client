module Nasdaq
  module Endpoints
    module ShortInterest
      def stock_short_interest(symbol)
        response = get(
          "/quote/#{symbol.upcase}/short-interest?assetClass=stocks", {}
        )

        short_interest_rows = response.dig('data', 'shortInterestTable', 'rows')

        raise Faraday::ResourceNotFound.new(symbol, response['message']) unless short_interest_rows

        short_interest_rows.map do |row|
          Nasdaq::Resources::ShortInterest.new(row)
        end
      end
    rescue Faraday::ResourceNotFound => e
      raise Nasdaq::Errors::SymbolNotFoundError.new(symbol, e.response)
    end
  end
end
