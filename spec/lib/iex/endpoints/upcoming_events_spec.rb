# frozen_string_literal: true

require 'spec_helper'

describe IEX::Endpoints::UpcomingEvents do
  include_context 'client'

  subject do
    iex_client.stock_events(symbol)
  end

  let(:dividends) { subject[:dividends] }
  let(:earnings) { subject[:earnings] }

  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'iex/upcoming_events/msft' } do
      let(:symbol) { 'MSFT' }

      it 'retrieves upcoming earning, dividend, and split events' do
        expect(dividends.size).to eq 1

        dividend = dividends.first
        expect(dividend.amount).to eq 0.56
        expect(dividend.currency).to eq 'USD'
        expect(dividend.declared_date).to eq '2020-12-02'
        expect(dividend.frequency).to eq 'quarterly'

        expect(earnings.count).to eq 0
      end
    end
  end

  context 'no result', vcr: { cassette_name: 'iex/upcoming_events/nsrgy' } do
    let(:symbol) { 'nsrgy' }

    it 'returns empty array' do
      expect(dividends).to eq []
      expect(earnings).to eq []
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'iex/upcoming_events/invalid' } do
    let(:symbol) { 'INVALID' }

    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
