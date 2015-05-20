require 'spec_helper'

describe MyDataProcessors::TimeSpentAverage do
  let(:spent_on) { 'google' }
  let(:visit_also) { 'facebook.com' }
  let(:since) { '20:00' }
  let(:to) { '23:00' }
  let(:filename) { 'some-file-name' }

  let(:options) do
    { spent_on: spent_on,
      visit_also: visit_also,
      since: since,
      to: to,
      filename: filename }
  end

  let(:processor) { described_class.new(options) }

  describe '.new' do
    let(:slices_to_check) { double(:slices_to_check) }

    before do
      allow_any_instance_of(described_class)
        .to receive(:slice_range).with(since, to).and_return(slices_to_check)
    end

    subject { processor }

    its(:slices_to_check) { is_expected.to be slices_to_check }
  end

  describe '#process!' do
    let(:spent_on_chunk) { build(:spread_chunk, id: spent_on) }
    let(:visit_also_chunk) { build(:spread_chunk, id: visit_also) }
    let(:other_chunk) { build(:spread_chunk) }
    let(:result) { double(:resutl) }

    subject { processor.process! }

    before do
      expect(processor).to receive(:process_file).with(filename) do
        processor.process_chunk_selection(spent_on_chunk)
        processor.process_chunk_selection(visit_also_chunk)
        processor.process_chunk_selection(other_chunk)
      end

      expect(processor).to receive(:process_chunk).once

      expect(processor).to receive(:result).and_return(result)
    end

    it { is_expected.to be result }
  end

  describe '#process_chunk_selection' do
    let(:chunk) { build(:spread_chunk, id: identifier) }

    before { processor.process_chunk_selection(chunk) }

    shared_examples 'adds also visitor key' do
      it { expect(processor.also_visitors.keys).to include('1', '2', '3') }
    end

    shared_examples 'does not add also visitor key' do
      it { expect(processor.also_visitors).to_not include('1', '2', '3') }
    end

    shared_examples 'adds chunk to chunks_to_check list' do
      it { expect(processor.chunks_to_check).to include(chunk) }
    end

    shared_examples 'does not add chunk to chunks_to_check list' do
      it { expect(processor.chunks_to_check).to_not include(chunk) }
    end

    context 'with visit also chunk' do
      let(:identifier) { processor.visit_also }

      it_behaves_like 'adds also visitor key'
      it_behaves_like 'does not add chunk to chunks_to_check list'
    end

    context 'with time spent on chunk' do
      let(:identifier) { processor.spent_on }

      it_behaves_like 'does not add also visitor key'
      it_behaves_like 'adds chunk to chunks_to_check list'
    end

    context 'with out of scope chunk' do
      let(:identifier) { 'other' }

      it_behaves_like 'does not add also visitor key'
      it_behaves_like 'does not add chunk to chunks_to_check list'
    end
  end

  describe '#process_chunk' do
    let(:chunk) { build(:spread_chunk) }

    before do
      processor.also_visitors['1'] = true
      processor.process_chunk(chunk)
    end

    it 'seconds_per_day list includes seconds spent just for also_visitors' do
      expect(processor.seconds_per_day.first).to eq 20
    end
  end

  describe '#result' do

    subject do
      processor.result
    end

    context 'with spent seconds in the list' do
      let(:seconds_per_day) { [2, 4, 3] }

      before do
        expect(processor).to receive(:seconds_per_day).exactly(3).times
          .and_return(seconds_per_day)
      end

      it { is_expected.to eq 3 }
    end

    context 'without spent seconds in the list' do
      let(:seconds_per_day) { [] }

      before do
        expect(processor).to receive(:seconds_per_day)
          .and_return(seconds_per_day)
      end

      it { is_expected.to eq 0 }
    end
  end
end
