module IEX
  module Endpoints
    module UpcomingEvents
      def stock_events(symbol, options = {})
        result = get("stock/#{symbol}/upcoming-events",
                     {
                       token: publishable_token,
                       # fullUpcomingEarnings: true
                     }.merge(options))

        earnings = result['earnings'].map do |event|
          IEX::Resources::EarningsEvent(event)
        end

        dividends = result['dividends'].map do |event|
          IEX::Resources::Dividends.new(event)
        end

        # splits = data['splits'].map do |event|
        #   IEX::Resources::Splits.new(event)
        # end

        {
          earnings: earnings,
          dividends: dividends
          # splits: splits
        }
      rescue Faraday::ResourceNotFound => e
        raise IEX::Errors::SymbolNotFoundError.new(symbol, e.response[:body])
      end

      # TODO: get market events data again
      # def market_events(options = {})
      #   # get("stock/market/upcoming-events", { token: publishable_token, fullUpcomingEarnings: true }.merge(options))['earnings'].map do |data|
      #   get("stock/market/upcoming-events?token=Tsk_e6fcd3bf4cd84d6698eff08b55a5d0a6",
      #       { use_sandbox: true }.merge(options)
      #      ).map do |data|
      #
      #     return data[1]
      #     # TODO: IEX::Resources::UpcomingMarketEvents.new(data)
      #   end
      # rescue Faraday::ResourceNotFound => e
      #   raise IEX::Errors::SymbolNotFoundError.new('market', e.response[:body])
      # end
    end
  end
end
