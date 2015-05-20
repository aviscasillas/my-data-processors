require 'spec_helper'

describe MyDataProcessors::Support::Callable do
  class FakeProcessor
    extend MyDataProcessors::Support::Callable
    def process!; end
  end

  describe '.call' do
    let(:result) { double(:result) }

    before do
      expect_any_instance_of(FakeProcessor)
        .to receive(:process!).and_return(result)
    end

    subject { FakeProcessor.call }

    it { is_expected.to be result }
  end
end
