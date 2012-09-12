require 'Store'

module Refactlabs
  module Stores
    class FourthStore < Store
		attr_accessor :price
	  
		def name
			"Fourth Store"
		end
		
		def price
			rand() * 100
		end
	  
    end
  end
end
