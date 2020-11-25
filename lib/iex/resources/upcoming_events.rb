module IEX
  module Resources
    class UpcomingEvents < Resource
      property 'symbol'
      property 'symbol_id', from: 'symbolId'
      property 'fiscal_period', from: 'fiscalPeriod'
      property 'fiscal_end_date', from: 'fiscalEndDate'
      property 'consensus_eps', from: 'consensusEPS'
      property 'num_of_estimates', from: 'numberOfEstimates'
      property 'report_date', from: 'reportDate'
      property 'announce_time', from: 'announceTime'
      property 'currency'
    end
  end
end
