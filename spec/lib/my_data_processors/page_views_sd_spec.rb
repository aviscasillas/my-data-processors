require 'spec_helper'

describe MyDataProcessors::PageViewsSD do
  let(:identifier) { 'facebook.com' }
  let(:visits_filename) { 'visits-filename' }
  let(:spread_filename) { 'spread-filename' }

  let(:options) do
    { identifier: identifier,
      visits_filename: visits_filename,
      spread_filename: spread_filename }
  end

  let(:processor) { described_class.new(options) }

  describe '#process!' do
    let(:result) { double(:result) }

    before do
      expect(processor).to receive(:process_file).with(visits_filename)
      expect(processor).to receive(:process_file).with(spread_filename)
      expect(processor).to receive(:result).and_return(result)
    end

    subject { processor.process! }

    it { is_expected.to be result }
  end

  describe '#process_visits_chunk' do
    let(:chunk) { build(:visits_chunk, id: chunk_id) }

    context 'with chunk in the scope' do
      let(:chunk_id) { identifier }

      it 'accumulates all visits' do
        expect(processor).to receive(:accumulate).exactly(6).times
      end
    end

    context 'with chunk out of scope' do
      let(:chunk_id) { 'other' }

      it 'does not accumulates visits' do
        expect(processor).to_not receive(:accumulate)
      end
    end

    after { processor.process_visits_chunk(chunk) }
  end

  describe '#process_spread_chunk' do
    let(:chunk) { build(:spread_chunk, id: chunk_id) }

    context 'with chunk in the scope' do
      let(:chunk_id) { identifier }

      it 'accumulates all visits' do
        expect(processor).to receive(:accumulate).exactly(9).times
      end
    end

    context 'with chunk out of scope' do
      let(:chunk_id) { 'other' }

      it 'does not accumulates visits' do
        expect(processor).to_not receive(:accumulate)
      end
    end

    after { processor.process_spread_chunk(chunk) }
  end

  describe '#result' do
    let(:sd) { double(:deviation) }

    before { expect(processor).to receive(:standard_deviation).and_return(sd) }

    subject { processor.result }

    it { is_expected.to be sd }
  end
end
