module Refactlabs
  module Frugal
    class PriceInfo
		attr_accessor :store_name, :sale_price
		
      def initialize(name, price)
        @store_name = name 
        @sale_price = price
      end

      def to_s
        "$ #{@sale_price} at #{@store_name}"
      end
    end
  end
end
