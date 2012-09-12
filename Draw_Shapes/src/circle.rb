require './src/shape.rb'
require './src/ui/circle_ui.rb'

class Circle < Shape
	include CircleDraw
	extend CircleUI

	attr_accessor :radius
	
	def initialize(x_coordinate, y_coordinate, radius)
		raise "Radius must be greater than 0." if radius <= 0 
		@x_pivot = x_coordinate
		@y_pivot = y_coordinate
		@radius = radius
	end
end