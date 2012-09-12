require 'test/unit'
require 'group'
require 'shape'

class TestGroup< Test::Unit::TestCase
	class Mock_Painter
		def draw_box(topleft, bottomright, color)
		end
		
		def draw_circle(center, radius, color)
		end
		
		def draw_polygon(list_of_points, color)
		end
		
		def draw_polygon_s(list_of_points, color)
		end
		
		def draw_text(text, x, y, color)
		end
	end

	def setup
		@group_of_shapes = Group.new
		@rectangle = Rectangle.new(0, 0, 4, 5)
		@circle = Circle.new(10, 10, 10)
		@square = Square.new(15, 15, 15)
		@screen = Mock_Painter.new
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
		assert_raise(RuntimeError){@group_of_shapes.delete_shape(@square)}
	end
	
	def test_delete_shape_with_identical_attributes
		@group_of_shapes.add_shape(@rectangle)
		rectangle2 = Rectangle.new(0, 0, 4, 5)
		assert_raise(RuntimeError){@group_of_shapes.delete_shape(rectangle2)}
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
		inner_group.add_shape(@circle)
		inner_group.add_shape(@square)
		
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.add_shape(inner_group)
		assert_equal(2, @group_of_shapes.shapes.size)
	end
	
	def test_deletion_of_group_from_a_group
		inner_group = Group.new
		inner_group.add_shape(@circle)
		inner_group.add_shape(@square)
		
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.add_shape(inner_group)
		@group_of_shapes.delete_shape(inner_group)
		assert_equal(1, @group_of_shapes.shapes.size)
	end
	
	def test_moving_single_shape
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.move_shape_by(10, 10)
		assert_equal(10, @rectangle.x_pivot)
		assert_equal(10, @rectangle.y_pivot)
	end
	
	def test_moving_two_shapes
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.add_shape(@square)
		@group_of_shapes.move_shape_by(15, 15)
		assert_equal(15, @rectangle.x_pivot)
		assert_equal(15, @rectangle.y_pivot)
		assert_equal(30, @square.x_pivot)
		assert_equal(30, @square.y_pivot)
	end
	
	def test_moving_group_within_group
		inner_group = Group.new
		inner_square = Square.new(12, 12, 12)
		inner_group.add_shape(inner_square)
		@group_of_shapes.add_shape(inner_group)
		@group_of_shapes.move_shape_by(-5, 5)
		assert_equal(7, inner_square.x_pivot)
		assert_equal(17, inner_square.y_pivot)
	end
	
	def test_moving_single_shape_and_single_group_within_group
		@group_of_shapes.add_shape(@rectangle)
		inner_group = Group.new
		inner_group.add_shape(@circle)
		@group_of_shapes.add_shape(inner_group)
		@group_of_shapes.move_shape_by(14, 40)
		assert_equal(14, @rectangle.x_pivot)
		assert_equal(40, @rectangle.y_pivot)
		assert_equal(24, @circle.x_pivot)
		assert_equal(50, @circle.y_pivot)
	end
	
	def test_draw_single_shape_in_group
		@group_of_shapes.add_shape(@rectangle)
		assert_nothing_raised{@group_of_shapes.draw(@screen)}
	end
	
	def test_draw_two_shapes_in_group
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.add_shape(@circle)
		assert_nothing_raised{@group_of_shapes.draw(@screen)}
	end
	
	def test_draw_shape_and_group_in_a_group
		inner_group = Group.new
		inner_group.add_shape(@square)
		@group_of_shapes.add_shape(@rectangle)
		@group_of_shapes.add_shape(inner_group)
		assert_nothing_raised{ @group_of_shapes.draw(@screen) }
	end
end