require './src/shape.rb'
require './src/ui/square_ui.rb'

class Square < Shape
	include SquareDraw
	extend SquareUI

	attr_accessor :length
	
	def initialize(x_coordinate, y_coordinate, length)
		raise "Length of a square must be greater than zero" if length <= 0
		@x_pivot = x_coordinate
		@y_pivot = y_coordinate
		@length = length
	end
end
