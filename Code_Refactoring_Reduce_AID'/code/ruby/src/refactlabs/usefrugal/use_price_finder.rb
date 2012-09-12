$LOAD_PATH << '../frugal'
$LOAD_PATH << '../stores'
require 'price_finder'
require 'XYZ_Store'
require 'Acme_Store'
require 'ABC_Store'
require 'Fourth_Store'

	store_object_array = Array.new
	child_class_array = Refactlabs::Stores::Store.descendants
	child_class_array.each {|child| store_object_array << child.new}

	priceFinder = Refactlabs::Frugal::PriceFinder.new(store_object_array)

	puts "Lowest price for Wii is #{priceFinder.get_frugal_price("Wii")}"

	puts "Lowest price for Nikon D90 is #{priceFinder.get_frugal_price("Nikon D90")}"
