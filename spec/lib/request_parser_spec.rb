require 'items'
require 'request_parser'

RSpec.shared_examples 'item by code given' do
  let(:code) { 'MB11' }
  let(:qty) { 12 }

  it { should eq([qty, code]) }
end

RSpec.describe RequestParser do
  describe '.call' do
    subject { described_class.call(line) }

    context 'when empty' do
      let(:line) { '' }

      it { expect { subject }.to raise_error(described_class::InvalidFormat) }
    end

    context 'when invalid format' do
      let(:line) { 'MB1112' }

      it { expect { subject }.to raise_error(described_class::InvalidFormat) }
    end

    context 'when valid' do
      let(:line) { "#{qty} #{code}" }

      context 'with MB11' do
        let(:code) { 'MB11' }
        let(:qty) { 12 }

        include_examples 'item by code given'
      end

      context 'with CF' do
        let(:code) { 'CF' }
        let(:qty) { 10 }

        include_examples 'item by code given'
      end

      context 'with CF' do
        let(:code) { 'VS5' }
        let(:qty) { 10 }

        include_examples 'item by code given'
      end
    end
  end
end
