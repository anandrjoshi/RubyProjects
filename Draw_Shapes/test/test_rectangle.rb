require 'test/unit'
require 'rectangle'

class TestRectangle< Test::Unit::TestCase
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
	
	def test_canary
		assert(true)
	end
	
	def setup
		@rectangle = Rectangle.new(0, 0, 3, 4)
		@screen = Mock_Painter.new
	end
	
	def test_rectangle_descendant_of_shape
		descendants_of_shape = Shape::descendants
		assert_equal(true, descendants_of_shape.include?(Rectangle))
	end
	
	def test_rectangle_created_correctly
		assert_equal(0, @rectangle.x_pivot)
		assert_equal(0, @rectangle.y_pivot)
		assert_equal(3, @rectangle.length)
		assert_equal(4, @rectangle.breadth)
	end

	def test_move_shape_by
		@rectangle.move_shape_by(10, -2)
		assert_equal(10, @rectangle.x_pivot)
		assert_equal(-2, @rectangle.y_pivot)
	end
	
	def test_rectangle_with_zero_length_and_breadth
		assert_raise(RuntimeError){Rectangle.new(0, 0, 0, 0)}
	end
	
	def test_draw
		assert_nothing_raised{ @rectangle.draw(@screen) }
	end
	
	def test_draw_sidebar_and_nothing_raised
		assert_nothing_raised{ Rectangle::draw_sidebar(@screen, {:x => 0, :y => 0, :length => 1, :breadth => 1}) }
	end
	
	def test_handle_mouse_input_and_nothing_raised
		@fields = {}
		Rectangle::initialize_temp_variables.each { |stmt| eval(stmt) }
		assert_nothing_raised do
			Rectangle::handle_mouse_input(0, 0)
			Rectangle::handle_mouse_input(650, 115)
			Rectangle::handle_mouse_input(740, 115)
			Rectangle::handle_mouse_input(650, 195)
			Rectangle::handle_mouse_input(740, 195)
			Rectangle::handle_mouse_input(650, 275)
			Rectangle::handle_mouse_input(740, 275)
			Rectangle::handle_mouse_input(650, 355)
			Rectangle::handle_mouse_input(740, 355)
			Rectangle::handle_mouse_input(720, 450)
		end
	end
end