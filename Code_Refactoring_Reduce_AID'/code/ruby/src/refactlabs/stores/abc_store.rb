require 'Store'

module Refactlabs
  module Stores
    class ABCStore < Store
		attr_accessor :price
	  
		def name
			"ABC Store"
		end
		
		def price
			rand() * 100
		end
	  
    end
  end
end
