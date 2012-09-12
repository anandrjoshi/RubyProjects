require 'test/unit'
require 'group'
require 'shape'

class TestGroup< Test::Unit::TestCase

	def setup
		@group_of_shapes = Group.new
		@rectangle = Rectangle.new(0,0,4,5)
		@circle = Circle.new(10,10,10)
		@square = Square.new(15,15,15) 
	end
	
	def test_array_created
		assert_equal(0, @group_of_shapes.shapes.length)
	end
	
	def test_add_two_shapes_to_group
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.add_shape(@circle)
		assert_equal(2, @group_of_shapes.shapes.size)
	end
	
	def test_shape_added_correctly_to_group
		@group_of_shapes.add_shape(@square)
		assert_equal(true, @group_of_shapes.shapes.include?(@square))
	end
	
	def test_shape_not_being_added_twice
		@group_of_shapes.add_shape(@square)
		assert_raise(RuntimeError){@group_of_shapes.add_shape(@square)}
	end
	
	def test_shape_deleted_from_group
		@group_of_shapes.add_shape(@square)
		@group_of_shapes.add_shape(@circle)
		@group_of_shapes.delete_shape(@square)
		assert_equal(1, @group_of_shapes.shapes.size)
	end
	
	def test_deleteing_shape_that_doesnot_exist_in_group
		@group_of_shapes.add_shape(@square)
		@group_of_shapes.delete_shape(@square)
		assert_raise(RuntimeError){@group_of_shapes.delete_shape(@square)}
	end
	
	def test_three_additions_and_two_deletions
		@group_of_shapes.add_shape(@square)
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.add_shape(@circle)
		@group_of_shapes.delete_shape(@square)
		@group_of_shapes.delete_shape(@circle)
		assert_equal(1, @group_of_shapes.shapes.size)
	end
	
	def test_add_group_to_a_group
		inner_group = Group.new
		inner_rectangle = Rectangle.new(12,12,14,12)
		inner_square = Square.new(12,12,12)
		inner_circle = Circle.new(12,12,10)
		inner_group.add_shape(inner_rectangle)
		inner_group.add_shape(inner_square)
		inner_group.add_shape(inner_circle)
		
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.add_shape(inner_group)
		assert_equal(2, @group_of_shapes.shapes.size)
	end
	
	def test_deletion_of_group_from_a_group
		inner_group = Group.new
		inner_rectangle = Rectangle.new(12,12,14,12)
		inner_square = Square.new(12,12,12)
		inner_circle = Circle.new(12,12,10)
		inner_group.add_shape(inner_rectangle)
		inner_group.add_shape(inner_square)
		inner_group.add_shape(inner_circle)
		
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.add_shape(@circle)
		@group_of_shapes.add_shape(inner_group)
		@group_of_shapes.delete_shape(inner_group)
		assert_equal(2, @group_of_shapes.shapes.size)
	end
	
	def test_moving_single_shape
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.move_shape(10,10)
		diagonally_opposite_vertex_x = @rectangle.vertices_list[2][0]
		diagonally_opposite_vertex_y = @rectangle.vertices_list[2][1]
		assert_equal(10, @rectangle.x_pivot)
		assert_equal(10, @rectangle.y_pivot)
		assert_equal(14, diagonally_opposite_vertex_x)
		assert_equal(15, diagonally_opposite_vertex_y)
	end
	
	def test_moving_group_within_group
		inner_group = Group.new
		inner_square = Square.new(12,12,12)
		inner_group.add_shape(inner_square)
		@group_of_shapes.add_shape(inner_group)
		@group_of_shapes.move_shape(5,5)
		assert_equal(5, inner_square.x_pivot)
		assert_equal(5, inner_square.y_pivot)
	end
	
	def test_moving_single_shape_and_single_group_within_group
		@group_of_shapes.add_shape(@rectangle)
		inner_group = Group.new
		inner_circle = Circle.new(5,5,12)
		inner_group.add_shape(inner_circle)
		@group_of_shapes.add_shape(inner_group)
		@group_of_shapes.move_shape(14,40)
		assert_equal(14, @rectangle.x_pivot)
		assert_equal(40, @rectangle.y_pivot)
		assert_equal(14, inner_circle.x_pivot)
		assert_equal(40, inner_circle.y_pivot)
	end
end