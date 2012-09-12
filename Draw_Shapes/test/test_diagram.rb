require 'test/unit'
require 'diagram'
require 'group'
require 'shape'

class TestDiagram< Test::Unit::TestCase

	def setup
		@file_name = "diagram.txt"
		@diagram = Diagram.new
		@rectangle = Rectangle.new(10, 10, 15, 20)
		@circle = Circle.new(12, 12, 23)
		@square = Square.new(25, 25, 40)
		@group = Group.new
	end
	
	def test_add_two_shapes
		@diagram.add_shape(@rectangle)
		@diagram.add_shape(@circle)
		assert_equal(2, @diagram.list_of_shapes.length)
		assert_equal(Rectangle, @diagram.list_of_shapes[0].class)
		assert_equal(Circle, @diagram.list_of_shapes[1].class)
	end
	
	def test_add_delete_shape
		@diagram.add_shape(@rectangle)
		@diagram.delete_shape(@rectangle)
		assert_equal(0, @diagram.list_of_shapes.length)
	end
	
	def test_delete_nonexistant_shape
		assert_raise(RuntimeError){@diagram.delete_shape(@rectangle)}
	end
	
	def test_shape_repeat_add
		@diagram.add_shape(@rectangle)
		assert_raise(RuntimeError){@diagram.add_shape(@rectangle)}
		assert_equal(1, @diagram.list_of_shapes.length)
	end
	
	def test_add_two_groups
		@group.add_shape(@rectangle)
		@group.add_shape(@circle)
		group2 = Group.new
		group2.add_shape(@square)
		@diagram.add_shape(@group)
		@diagram.add_shape(group2)
		assert_equal(2, @diagram.list_of_shapes.length)
	end
	
	def test_add_and_delete_group
		@group.add_shape(@rectangle)
		@group.add_shape(@circle)
		@diagram.add_shape(@group)
		@diagram.delete_shape(@group)
		assert_equal(0, @diagram.list_of_shapes.length)
	end
	
	def test_delete_nonexistant_group
		@group.add_shape(@rectangle)
		assert_raise(RuntimeError){@diagram.delete_shape(@group)}
	end
	
	def test_add_group_repeat
		@group.add_shape(@rectangle)
		@diagram.add_shape(@group)
		@diagram.add_shape(@square)
		assert_raise(RuntimeError){@diagram.add_shape(@group)}
		assert_equal(2, @diagram.list_of_shapes.length)
	end
	
	def test_load_from_nonexistant_file
		assert_raise(RuntimeError){Diagram::load_diagram("random.txt")}
	end
	
	def test_load_from_non_Marshal_format
		assert_raise(RuntimeError){Diagram::load_diagram("assign3.txt")}
	end
	
	def test_save_and_load_shape
		@diagram.add_shape(@rectangle)
		@diagram.save_diagram(@file_name)
		
		@diagram = Diagram::load_diagram(@file_name)
		assert_equal(10, @diagram.list_of_shapes[0].x_pivot)
		assert_equal(10, @diagram.list_of_shapes[0].y_pivot)
		assert_equal(15, @diagram.list_of_shapes[0].length)
		assert_equal(20, @diagram.list_of_shapes[0].breadth)
	end
	
	def test_save_and_load_of_two_shape
		@diagram.add_shape(@square)
		@diagram.add_shape(@circle)
		@diagram.save_diagram(@file_name)
		  
		@diagram = Diagram::load_diagram(@file_name)
		assert_equal(2, @diagram.list_of_shapes.length)
		
	end
	
	def test_save_and_load_after_one_shape_is_deleted
		@diagram.add_shape(@square)
		@diagram.add_shape(@rectangle)
		@diagram.delete_shape(@square)
		@diagram.save_diagram(@file_name)
		 
		@diagram = Diagram::load_diagram(@file_name)
		assert_equal(1, @diagram.list_of_shapes.length)
	end
	
	def test_save_and_load_group_of_three_shapes
		group_shape = Group.new
		group_shape.add_shape(@rectangle)
		group_shape.add_shape(@square)
		group_shape.add_shape(@circle)
		@diagram.add_shape(group_shape)
		@diagram.save_diagram(@file_name)
		
		@diagram = Diagram::load_diagram(@file_name)
		assert_equal(1, @diagram.list_of_shapes.length)
		assert_equal(3, @diagram.list_of_shapes[0].shapes.length)
		assert_equal(Rectangle, @diagram.list_of_shapes[0].shapes[0].class)
		assert_equal(Square, @diagram.list_of_shapes[0].shapes[1].class)
		assert_equal(Circle, @diagram.list_of_shapes[0].shapes[2].class)
	end
	
	def test_save_and_load_group_of_one_shape_and_two_shapes
		group_shape = Group.new
		group_shape.add_shape(@rectangle)
		@diagram.add_shape(group_shape)
		@diagram.add_shape(@square)
		@diagram.add_shape(@circle)
		@diagram.save_diagram(@file_name)
		
		@diagram = Diagram::load_diagram(@file_name)
		assert_equal(3, @diagram.list_of_shapes.length)
		assert_equal(1, @diagram.list_of_shapes[0].shapes.length)
		assert_equal(Rectangle, @diagram.list_of_shapes[0].shapes[0].class)
		assert_equal(Square, @diagram.list_of_shapes[1].class)
		assert_equal(Circle, @diagram.list_of_shapes[2].class)
	end
	
	def test_save_load_group_within_a_group
		outer_group = Group.new
		inner_group = Group.new
		inner_group.add_shape(@square)
		outer_group.add_shape(inner_group)
		outer_group.add_shape(@rectangle)
		@diagram.add_shape(outer_group)
		@diagram.save_diagram(@file_name)
		
		@diagram = Diagram::load_diagram(@file_name)
		assert_equal(1, @diagram.list_of_shapes.length)
		assert_equal(Group, @diagram.list_of_shapes[0].class)
		assert_equal(Group, @diagram.list_of_shapes[0].shapes[0].class)
		assert_equal(Rectangle, @diagram.list_of_shapes[0].shapes[1].class)
		assert_equal(Square, @diagram.list_of_shapes[0].shapes[0].shapes[0].class)
	end
end