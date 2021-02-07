require 'spec_helper'

describe Nasdaq::Endpoints::ShortInterest do
  include_context 'client'

  subject { nasdaq_client.stock_short_interest(ticker) }

  context 'valid symbol', vcr: { cassette_name: 'nasdaq/short_interest/tsla' } do
    let(:ticker) { 'TSLA' }

    it 'retrieves short interest' do
      res = subject
      expect(subject.count).to eq 23
      
      first_row = subject.first
      expect(first_row.settlement_date_s).to eq '01/15/2021'
      expect(first_row.interest.to_i).to eq 56367815
      expect(first_row.avg_daily_share_volume).to eq 42129010
      expect(first_row.days_to_cover).to eq 1.337981
    end
  end

  context 'symbol not on NASDAQ', vcr: { cassette_name: 'nasdaq/short_interest/gme' } do
    let(:ticker) { 'gme' }

    it 'retrieves guidance' do
      expect { subject }.to raise_error Faraday::ResourceNotFound
    end
  end
end
