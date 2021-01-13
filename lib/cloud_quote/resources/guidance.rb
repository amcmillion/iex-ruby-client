module CloudQuote
  module Resources
    class Guidance < Resource
      property 'date'
      property 'time'
      property 'ticker'
      property 'exchange'
      property 'name'
      property 'period'
      property 'period_year'
      property 'is_primary'
      property 'prelim'
      property 'currency'
      property 'eps_type'
      property 'eps_guidance_est'
      property 'eps_guidance_min'
      property 'eps_guidance_max'
      property 'eps_guidance_prior_min'
      property 'eps_guidance_prior_max'
      property 'revenue_type'
      property 'revenue_guidance_est'
      property 'revenue_guidance_min'
      property 'revenue_guidance_max'
      property 'revenue_guidance_prior_min'
      property 'revenue_guidance_prior_max'
      property 'importance'
      property 'notes'
      property 'updated'

      FLOAT_PROPS = %w[
        eps_guidance_est
        eps_guidance_max
        eps_guidance_min
        eps_guidance_prior_max
        eps_guidance_prior_min
        revenue_guidance_est
        revenue_guidance_max
        revenue_guidance_min
        revenue_guidance_prior_max
        revenue_guidance_prior_min
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
