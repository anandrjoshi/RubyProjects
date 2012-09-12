require 'Store'

module Refactlabs
  module Stores
    class AcmeStore < Store
		attr_accessor :price

		def name
			"Acme Store"
		end
		
		def price
			rand() * 100
		end
    end
  end
end
