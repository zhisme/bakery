module ResultLogger
  extend self

  def info(total_qty, code, total_price, described_prices)
    header = header(total_qty, code, total_price)
    puts header

    described_prices.each do |price_arr|
      puts add_padding(content(price_arr), header.size)
    end
  end

  private

  # TODO: total_price
  def header(total_qty, code, total_price)
    fmt = format('%d %s $%g', total_qty, code, total_price)
  end

  def content(price_arr)
    pack, count, price = price_arr

    fmt = format('%d x %d $%g', pack, count, price)
  end

  def add_padding(content, header_size)
    padding = ' ' * (header_size / 2)

    content.prepend(padding)
  end
end
