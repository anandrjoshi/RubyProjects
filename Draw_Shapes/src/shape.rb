
class Shape
	attr_accessor :x_pivot, :y_pivot
	
	def move_shape_by(change_in_x, change_in_y)
		@x_pivot += change_in_x
		@y_pivot += change_in_y
	end
	
	def self.descendants
	    children = []
		ObjectSpace.each_object(Class) do |klass|
			children = children << klass if klass < self
	    end
		children
	end
end