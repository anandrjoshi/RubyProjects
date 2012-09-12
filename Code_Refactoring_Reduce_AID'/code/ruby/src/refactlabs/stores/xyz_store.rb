require 'Store'

module Refactlabs
  module Stores
    class XYZStore < Store
		attr_accessor :price

		def name
			"XYZ Store"
		end
		
		def price
			rand() * 100
		end
    end
  end
end
