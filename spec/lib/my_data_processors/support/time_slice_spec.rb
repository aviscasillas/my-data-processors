require 'spec_helper'

describe MyDataProcessors::Support::TimeSlice do
  let(:described_instance) { Object.new.extend described_class }

  describe '#slice_range' do
    subject { described_instance.slice_range('20:00', '23:00') }
    it { is_expected.to eq (80..92).to_a }
  end

  describe '#slice_from_time' do
    subject { described_instance.slice_from_time('20:00') }
    it { is_expected.to eq 80 }
  end
end
