module IEX
  module Resources
    class InsiderTransactions < Resource
      property 'conversion_or_exercise_price', from: 'conversionOrExercisePrice'
      property 'direct_indirect', from: 'directIndirect'
      property 'effective_date', from: 'effectiveDate'
      property 'full_name', from: 'fullName'
      property 'is_10b51', from: 'is10b51'
      property 'post_shares', from: 'postShares'
      property 'reported_title', from: 'reportedTitle'
      property 'symbol'
      property 'transaction_code', from: 'transactionCode'
      property 'transaction_date', from: 'transactionDate'
      property 'transaction_price', from: 'transactionPrice'
      property 'transaction_value', from: 'transactionValue'
      property 'id'
      property 'key'
      property 'subkey'
      property 'date'
      property 'updated'
      property 'tran_price', from: 'tranPrice'
      property 'tran_shares', from: 'tranShares'
      property 'tran_value', from: 'tranValue'
    end
  end
end
