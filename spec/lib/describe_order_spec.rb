require 'describe_order'
require 'items'
require 'change_maker'

RSpec.describe DescribeOrder do
  describe '.call' do
    subject { described_class.call(item) }

    context 'BlueberryMuffin' do
      let(:item) { Items::BlueberryMuffin.new(14).pack_order }

      it { should eq([14, 'MB11', 54.8, [['8', 1, 24.95], ['2', 3, 9.95]]]) }
    end

    context 'Croissant' do
      let(:item) { Items::Croissant.new(13).pack_order }

      it { should eq([13, 'CF', 25.849999999999998, [['5', 2, 9.95], ['3', 1, 5.95]]]) }
    end

    context 'VegemiteScroll' do
      let(:item) { Items::Croissant.new(10).pack_order }

      it { should eq([10, 'CF', 19.9, [['5', 2, 9.95]]]) }
    end
  end
end
