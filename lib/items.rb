module Items
  class NoOption < StandardError; end
  class ItemNotFound < StandardError; end

  class Finder
    def self.find_by(code:)
      item_class_name = Items.constants.select { |c| Items.const_get(c).is_a? Class }.
        find { |c| Items.const_get(c).instance_variable_get(:@code) == code }

      Items.const_get item_class_name.to_s
    rescue NameError
      raise ItemNotFound, code
    end
  end

  class Base
    attr_reader :count, :packed

    @packs_size = []
    @prices = {}
    @code = ''

    class << self
      attr_reader :packs_size, :code, :prices
    end

    def initialize(count)
      @count = count
    end

    def price(pack_size)
      self.class.prices[pack_size]
    end

    def pack_order
      @packed = ChangeMaker.call(count, self.class.packs_size)

      raise NoOption if packed.nil?

      self
    end
  end

  class VegemiteScroll < Base
    @packs_size = [3, 5]
    @prices = {
      '3' => 6.99,
      '5' => 8.99,
    }
    @code = 'VS5'
  end

  class BlueberryMuffin < Base
    @packs_size = [2, 5, 8]
    @prices = {
      '2' => 9.95,
      '5' => 16.95,
      '8' => 24.95,
    }
    @code = 'MB11'
  end

  class Croissant < Base
    @packs_size = [3, 5, 9]
    @prices = {
      '3' => 5.95,
      '5' => 9.95,
      '9' => 16.99,
    }
    @code = 'CF'
  end
end
