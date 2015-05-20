require 'spec_helper'

describe MyDataProcessors::Models::Chunk do
  let(:encoded_data) { 'encoded-data' }
  let(:decoded_data) { 'decoded-data' }

  before do
    expect_any_instance_of(described_class).to receive(:decode)
      .with(encoded_data).and_return(decoded_data)
  end

  subject { described_class.new(encdata: encoded_data) }

  its(:data) { is_expected.to be decoded_data }
end
