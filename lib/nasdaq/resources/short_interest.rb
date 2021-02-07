module Nasdaq
  module Resources
    class ShortInterest < Resource
      property 'settlement_date_s', from: 'settlementDate'
      property 'interest', transform_with: ->(v) { string_to_int(v) }
      property 'avg_daily_share_volume', from: 'avgDailyShareVolume', with: ->(v) { string_to_int(v) }
      property 'days_to_cover', from: 'daysToCover'

      FLOAT_PROPS = %w[
        days_to_cover
      ].freeze

      INT_PROPS = %w[
        interest
        avg_daily_share_volume
      ].freeze

      def initialize(data)
        super

        # Cast string-represented floats into actual floats
        FLOAT_PROPS.map do |prop_name|
          self[prop_name] = self[prop_name].to_f if self[prop_name].is_a? String
        end
      end
    end
  end
end
