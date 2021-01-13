require 'spec_helper'

describe CloudQuote::Resources::Guidance do
  include_context 'client'

  subject {
    cq_client.guidance(start_date, end_date)
  }

  context 'end date is before start date' do
    let(:start_date) { Date.new(2020, 12, 11) }
    let(:end_date) { Date.new(2020, 1, 9) }

    it 'retrieves guidance' do
      expect { subject }.to raise_error ArgumentError
    end
  end

  context '1 month range', vcr: { cassette_name: 'cq/guidance/1_month_range' } do
    let(:start_date) { Date.new(2020, 12, 11) }
    let(:end_date) { Date.new(2021, 1, 9) }

    it 'retrieves guidance' do
      expect(subject.count).to eq 50
      
      ntus_guidance = subject.first
      expect(ntus_guidance.date).to eq '2021-01-08'
      expect(ntus_guidance.time).to eq '16:47:07'
      expect(ntus_guidance.ticker).to eq 'NTUS'
      expect(ntus_guidance.name).to eq 'Natus Medical'
      expect(ntus_guidance.period).to eq 'Q4'
      expect(ntus_guidance.period_year).to eq 2020
      expect(ntus_guidance.eps_guidance_est).to eq 0.240
      expect(ntus_guidance.revenue_guidance_est).to eq 110000000.000

      CloudQuote::Resources::Guidance::FLOAT_PROPS.map do |prop_name|
        expect(ntus_guidance[prop_name]).to be_a Float
      end
    end
  end

  context '1 day range', vcr: { cassette_name: 'cq/guidance/1_day_range' } do
    let(:start_date) { Date.new(2021, 1, 5) }
    let(:end_date) { Date.new(2021, 1, 5) }

    it 'retrieves guidance' do
      expect(subject.count).to eq 9

      CloudQuote::Resources::Guidance::FLOAT_PROPS.map do |prop_name|
        expect(subject.first[prop_name]).to be_a Float
      end
    end
  end
end
