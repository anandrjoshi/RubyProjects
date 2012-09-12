require './src/shape.rb'
require './src/ui/rectangle_ui.rb'

class Rectangle < Shape
	include RectangleDraw
	extend RectangleUI

	attr_accessor :length, :breadth
	
	def initialize(x_coordinate, y_coordinate, length, breadth)
		raise "Length and breadth must be greater than 0." if length <= 0 or breadth <= 0 
		@x_pivot = x_coordinate
		@y_pivot = y_coordinate
		@length = length
		@breadth = breadth
	end
end