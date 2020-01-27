module RequestParser
  extend self

  class InvalidFormat < StandardError; end

  def call(input_line)
    regexp = /(\d+)\s(#{available_codes})/
    match, qty, code = input_line.match(regexp).to_a

    raise InvalidFormat if match.nil?

    [qty.to_i, code]
  end

  private

  def available_codes
    [
      Items::VegemiteScroll.code,
      Items::BlueberryMuffin.code,
      Items::Croissant.code,
    ].join('|')
  end
end
