require 'change_maker'

RSpec.shared_examples 'presence' do
  it { expect(subject).to_not be_empty }
end

RSpec.describe ChangeMaker do
  describe '.call' do
    subject { described_class.call(count, list) }
    let(:list) { [2, 5, 8] }

    context 'when available' do
      let(:count) { 14 }

      include_examples 'presence'
      it { should eq([8, 2, 2, 2]) }
    end

    context 'when invalid' do
      let(:count) { -10 }

      it { expect(subject).to eq(nil) }
    end

    context 'when impossible' do
      let(:count) { 3 }

      it { expect(subject).to eq(nil) }
    end
  end
end
