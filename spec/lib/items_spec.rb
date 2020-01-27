require 'items'
require 'change_maker'

RSpec.describe Items::Finder do
  describe '.find_by' do
    subject { described_class.find_by(code: code) }

    let(:code) { 'VS5' }

    context 'VegemiteScroll' do
      it { should eq(Items::VegemiteScroll) }
    end

    context 'Croissant' do
      let(:code) { 'CF' }

      it { should eq(Items::Croissant) }
    end

    context 'BlueberryMuffin' do
      let(:code) { 'MB11' }

      it { should eq(Items::BlueberryMuffin) }
    end

    context 'Invalid' do
      let(:code) { 'Invalid' }

      it { expect { subject }.to raise_error(Items::ItemNotFound) }
    end
  end
end

RSpec.describe Items do
  describe '.new' do
    subject { described_class::Croissant.new(count) }

    let(:count) { 10 }

    it { should be_a(Items::Croissant) }
    it { expect(subject.count).to eq(10) }
  end

  describe '.price' do
    subject { described_class::Croissant.new(count).price(pack_size) }

    let(:count) { 10 }

    context 'when valid' do
      let(:pack_size) { '3' }

      it { should eq(described_class::Croissant.prices[pack_size]) }
    end

    context 'when invalid' do
      let(:pack_size) { '8' }

      it { should eq(nil) }
    end
  end

  describe '.pack_order' do
    subject { described_class::Croissant.new(count).pack_order.packed }

    let(:change_maker) { class_double(ChangeMaker) }

    context 'when valid' do
      let(:count) { 6 }

      before do
        allow(change_maker).to receive(:call).with(count, described_class::Croissant.packs_size).and_return([3, 3])
      end

      it { should eq([3, 3]) }
    end

    context 'when invalid' do
      let(:count) { 2 }

      before do
        allow(change_maker).to receive(:call).with(count, described_class::Croissant.packs_size).and_return([3, 3])
      end

      it { expect { subject }.to raise_error(Items::NoOption) }
    end
  end
end
