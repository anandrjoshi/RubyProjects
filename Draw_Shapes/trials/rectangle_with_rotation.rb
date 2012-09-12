

class Rectangle
	attr_accessor :x_pivot, :y_pivot, :length, :breadth, :degree_of_rotation, :vertices_list
	
	def initialize(x_coordinate, y_coordinate, length, breadth)
		raise "Length and breadth must be greater than 0." if length <= 0 or breadth <= 0 
		@x_pivot = x_coordinate
		@y_pivot = y_coordinate
		@length = length
		@breadth = breadth
		@degree_of_rotation = 0
		@vertices_list = []
		initialize_vertices
	end
	
	def initialize_vertices
		@vertices_list << [@x_pivot, @y_pivot]
		@vertices_list << [@x_pivot + @length, @y_pivot]
		@vertices_list << [@x_pivot + @length, @y_pivot + @breadth]
		@vertices_list << [@x_pivot, @y_pivot + @breadth]
	end
	
	def rotate_by_degree(degree)
		@degree_of_rotation += degree
		@vertices_list.each_index do |index|
			@vertices_list[index] = rotate_around(@vertices_list[0], @vertices_list[index], degree) unless @vertices_list[0] == @vertices_list[index]
		end
	end
	
	def rotate_around(vertex1, vertex2, degree)
		distance = distance_between_points(vertex1,vertex2)
		angle = vertex2[0] == vertex1[0] ? (vertex2[1] > vertex1[1] ? -Math::PI/2 : Math::PI/2) 
					: Math.atan(-(vertex2[1]-vertex1[1]).to_f/(vertex2[0]-vertex1[0]).to_f)
					
		angle += degree*Math::PI/180
		v3 = [vertex1[0] + distance*Math.cos(angle), vertex1[1] - distance*Math.sin(angle)] 
	end
	
	def distance_between_points(point1, point2)
		Math.sqrt((point2[1]-point1[1])**2 + (point2[0]-point1[0])**2)
	end
	
	def move_to_new_position(change_in_x, change_in_y)
		@vertices_list.each_index do |index|
			@vertices_list[index] = [@vertices_list[index][0] + change_in_x, @vertices_list[index][1] + change_in_y]
		end
	end
end