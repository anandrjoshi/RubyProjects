require 'test/unit'
require 'price_finder'

class TestPriceFinder < Test::Unit::TestCase
	class Mock_Store 
		attr_accessor :name, :price
		def initialize (store_name, store_price)
			@name = store_name
			@price = store_price
		end
	end
	
	def setup
		@pricefinder = Refactlabs::Frugal::PriceFinder.new([])
		@mock_store_0 = Mock_Store.new("Zero Dollar Store", 0)
		@mock_store_10 = Mock_Store.new("Ten Dollar Store", 10)
		@mock_store_10_duplicate = Mock_Store.new("Duplicate Ten Dollar Store", 10)
	end
	
	def test_canary
		assert(true)
	end
	
	def test_exception_raised_with_empty_store_list
		@pricefinder.stores_list = []
		assert_raise(RuntimeError) { @pricefinder.get_frugal_price("XBox") }
	end	

	def test_get_frugal_price_with_one_store
		@pricefinder.stores_list = [@mock_store_0]
		assert_equal(0, @pricefinder.get_frugal_price("XBox").sale_price)
	end	
	
	def test_get_frugal_price_store_name_with_one_store
		@pricefinder.stores_list = [@mock_store_10]
		assert_equal("Ten Dollar Store", @pricefinder.get_frugal_price("XBox").store_name)
	end	
	
	def test_get_frugal_price_with_two_stores
		@pricefinder.stores_list = [@mock_store_0,@mock_store_10]
		assert_equal(0, @pricefinder.get_frugal_price("XBox").sale_price)
	end
	
	def test_get_frugal_price_store_name_with_two_stores
		@pricefinder.stores_list = [@mock_store_0,@mock_store_10]
		assert_equal("Zero Dollar Store", @pricefinder.get_frugal_price("XBox").store_name)
	end
	
	def test_get_frugal_price_store_name_with_two_stores_with_same_price
		@pricefinder.stores_list = [@mock_store_10,@mock_store_10_duplicate]
		assert_equal("Ten Dollar Store", @pricefinder.get_frugal_price("XBox").store_name)
	end
	
	def test_get_frugal_price_with_invalid_store
		@pricefinder.stores_list = [@mock_store_0, "Invalid Store", @mock_store_10]
		assert_equal("Zero Dollar Store", @pricefinder.get_frugal_price("XBox").store_name)
	end
	
	def test_exception_raised_when_only_invalid_store_present
		@pricefinder.stores_list = ["Invalid Store"]
		assert_raise(RuntimeError) { @pricefinder.get_frugal_price("XBox") }
	end
end
  