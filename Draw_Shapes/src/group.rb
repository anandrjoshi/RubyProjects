require './src/shape.rb'
require './src/ui/group_ui.rb'

class Group
	include GroupDraw

	attr_accessor :shapes
	
	def initialize
		@shapes= Array.new
	end
	
	def add_shape(shape)
		raise "Shape already belongs to this group. So cannot add it again." if @shapes.include?(shape)
		@shapes << shape
	end
	
	def delete_shape(shape)
		raise "Shape does not belong in this group. So cannot delete it." if !@shapes.include?(shape)
		@shapes.delete(shape)
	end
	
	def move_shape_by(move_x_by, move_y_by)
		@shapes.each {|shape| shape.move_shape_by(move_x_by, move_y_by)}
	end
end