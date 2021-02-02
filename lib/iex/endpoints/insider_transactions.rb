module IEX
  module Endpoints
    module InsiderTransactions
      def insider_transactions(symbol, options = {})
        (get("stock/#{symbol}/insider-transactions", { token: publishable_token }.merge(options))).map do |data|
          IEX::Resources::InsiderTransactions.new(data)
        end
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end
    end
  end
end
