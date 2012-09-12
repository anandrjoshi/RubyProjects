require 'shape'

class Group
	attr_accessor :shapes
	
	def initialize
		@shapes = Array.new
	end
	
	def add_shape(shape)
		raise "Shape already belongs to this group. So cannot add it again." if @shapes.include?(shape)
		@shapes << shape
	end
	
	def delete_shape(shape)
		raise "Shape does not belong in this group. So cannot delete it." if !@shapes.include?(shape)
		@shapes.delete(shape)
	end
	
	def move_shape(new_position_x, new_position_y)
		@shapes.each do |shape| 
			if shape.class == Group
				shape.move_shape(new_position_x, new_position_y)
			else
				shape.move_to_new_position(new_position_x, new_position_y) 
			end
		end			
	end
end