#!/usr/bin/env ruby

Dir['./lib/**/*.rb'].each { |file| require file }

ARGF.each do |line|
  qty, code = RequestParser.call(line)
  item = Items::Finder.find_by(code: code).new(qty).pack_order
  order_described = DescribeOrder.call(item)
  ResultLogger.info(*order_described)
rescue RequestParser::InvalidFormat
  p 'Format invalid. Skipped.'
rescue Items::NoOption
  p "Cannot offer anything with #{code} #{qty}."
end
