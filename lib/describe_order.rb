module DescribeOrder
  extend self

  def call(item)
    count_entries = item.packed.group_by { |v| v }.map { |k, v| [k.to_s, v.size] }.to_h

    described_prices = count_entries.map { |pack, count| [pack, count, item.price(pack)] }
    total_price = count_entries.inject(0) { |acc, (pack, count)| acc += item.price(pack) * count; acc }

    [item.count, item.class.code, total_price, described_prices]
  end
end
