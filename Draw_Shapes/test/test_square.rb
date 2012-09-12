require 'test/unit'
require 'square'

class TestSquare < Test::Unit::TestCase
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
		@square = Square.new(0, 0, 4)
		@screen = Mock_Painter.new
	end
	
	def test_square_descendant_of_shape
		descendants_of_shape = Shape::descendants
		assert_equal(true, descendants_of_shape.include?(Square))
	end
	
	def test_square_with_zero_length
		assert_raise(RuntimeError){Square.new(0, 0, 0)}
	end
	
	def test_square_created_correctly
		assert_equal(0, @square.x_pivot)
		assert_equal(0, @square.y_pivot)
		assert_equal(4, @square.length)
	end
	
	def test_move_shape_by
		@square.move_shape_by(15.5, 10.2)
		assert_equal(15.5, @square.x_pivot)
		assert_equal(10.2, @square.y_pivot)
	end
	
	def test_square_with_negative_length
		assert_raise(RuntimeError){Square.new(0, 0, -1)}
	end
	
	def test_draw
		assert_nothing_raised{@square.draw(@screen)}
	end
	
	def test_draw_sidebar_and_nothing_raised
		assert_nothing_raised{ Square::draw_sidebar(@screen, {:x => 0, :y => 0, :length => 1}) }
	end
	
	def test_handle_mouse_input_and_nothing_raised
		@fields = {}
		Square::initialize_temp_variables.each { |stmt| eval(stmt) }
		assert_nothing_raised do
			Square::handle_mouse_input(0, 0)
			Square::handle_mouse_input(650, 115)
			Square::handle_mouse_input(740, 115)
			Square::handle_mouse_input(650, 195)
			Square::handle_mouse_input(740, 195)
			Square::handle_mouse_input(650, 275)
			Square::handle_mouse_input(740, 275)
			Square::handle_mouse_input(720, 360)
		end
	end
end
