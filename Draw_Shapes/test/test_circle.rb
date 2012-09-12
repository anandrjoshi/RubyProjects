require 'test/unit'
require 'circle'

class TestCircle< Test::Unit::TestCase
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
		@screen = Mock_Painter.new
		@circle = Circle.new(20, 20, 5)
	end
		
	def test_circle_descendant_of_shape
		descendants_of_shape = Shape::descendants
		assert_equal(true, descendants_of_shape.include?(Circle))
	end
	
	
	def test_center_placed_correctly
		assert_equal(20, @circle.x_pivot)
		assert_equal(20, @circle.y_pivot)
		assert_equal(5, @circle.radius)
	end

	def test_move_to_new_center
		@circle.move_shape_by(50, 50)
		assert_equal(70, @circle.x_pivot)
		assert_equal(70, @circle.y_pivot)
		assert_equal(5,  @circle.radius)
	end
	
	def test_circle_with_zero_radius
		assert_raise(RuntimeError){Circle.new(0, 0, 0)}
	end
	
	def test_draw
		assert_nothing_raised{@circle.draw(@screen)}
	end
	
	def test_draw_sidebar_and_nothing_raised
		assert_nothing_raised{ Circle::draw_sidebar(@screen, {:x => 0, :y => 0, :radius => 1}) }
	end
	
	def test_handle_mouse_input_and_nothing_raised
		@fields = {}
		Circle::initialize_temp_variables.each { |stmt| eval(stmt) }
		assert_nothing_raised do
			Circle::handle_mouse_input(0, 0)
			Circle::handle_mouse_input(650, 115)
			Circle::handle_mouse_input(740, 115)
			Circle::handle_mouse_input(650, 195)
			Circle::handle_mouse_input(740, 195)
			Circle::handle_mouse_input(650, 275)
			Circle::handle_mouse_input(740, 275)
			Circle::handle_mouse_input(720, 360)
		end
	end
end