require 'price_info'

module Refactlabs
  module Frugal
    class PriceFinder
		 attr_accessor :stores_list
		
		 def initialize (store_object_array)
			 @stores_list = store_object_array
		 end
		
		def get_frugal_price(product)
			lowest_price_info = nil
			@stores_list.each do |store_object| 
				if store_object.respond_to?('price') and (lowest_price_info.nil? or store_object.price < lowest_price_info.sale_price)
					lowest_price_info = PriceInfo.new(store_object.name, store_object.price) 
				end
			end
			raise "No valid stores found." if lowest_price_info.class == NilClass
			lowest_price_info
		end	
    end
  end
end
