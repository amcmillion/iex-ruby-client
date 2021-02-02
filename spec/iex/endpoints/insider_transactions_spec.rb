# frozen_string_literal: true

require 'spec_helper'

describe IEX::Resources::InsiderTransactions do
  include_context 'client'

  context 'known symbol' do
    context 'with defaults', vcr: { cassette_name: 'iex/insider_transactions/aapl' } do
      subject do
        iex_client.insider_transactions('AAPL')
      end
      let(:insider_transactions) { subject.first }

      it 'retrieves insider transactions' do
        pp subject
        expect(subject.size).to eq 37
        expect(insider_transactions.conversion_or_exercise_price).to be_nil
        expect(insider_transactions.direct_indirect).to eq 'D'
        expect(insider_transactions.effective_date).to eq 1580688000000
        expect(insider_transactions.filing_date).to eq '2020-02-04'
        expect(insider_transactions.full_name).to eq 'LEVINSON ARTHUR D'
        expect(insider_transactions.is_10b51).to eq false
        expect(insider_transactions.post_shares).to eq 1133280
        expect(insider_transactions.reported_title).to be_nil
        expect(insider_transactions.symbol).to eq 'AAPL'
        expect(insider_transactions.transaction_code).to eq 'S'
        expect(insider_transactions.transaction_date).to eq '2020-02-03'
        expect(insider_transactions.transaction_price).to eq 304.11
        expect(insider_transactions.transaction_shares).to eq -1429
        expect(insider_transactions.transaction_value).to eq 434573
        expect(insider_transactions.id).to eq 'INSIDER_TRANSACTIONS'
        #expect(insider_transactions.key).to eq 'AAPL'
        expect(insider_transactions.subkey).to eq '0000320193-20-000021'
        expect(insider_transactions.date).to eq 1580688000000
        expect(insider_transactions.updated).to eq 1610580919000
        expect(insider_transactions.tran_price).to eq 304.11
        expect(insider_transactions.tran_shares).to eq -1429
        expect(insider_transactions.tran_value).to eq 434573
      end
    end
  end

  context 'no result', vcr: { cassette_name: 'iex/insider_transactions/nsrgy' } do
    subject do
      iex_client.insider_transactions('nsrgy')
    end
    it 'returns empty array' do
      expect(subject).to eq []
    end
  end

  context 'invalid symbol', vcr: { cassette_name: 'iex/insider_transactions/invalid' } do
    subject do
      iex_client.insider_transactions('INVALID')
    end
    it 'fails with SymbolNotFoundError' do
      expect { subject }.to raise_error IEX::Errors::SymbolNotFoundError, 'Symbol INVALID Not Found'
    end
  end
end
