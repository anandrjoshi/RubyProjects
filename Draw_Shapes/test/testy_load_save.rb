require 'test/unit'
require 'load_save'
require 'group'
require 'shape'

class TestLoadSave< Test::Unit::TestCase

	def setup
		@file_name = "diagram.txt"
		@load_save = LoadSave.new(@file_name)
		@rectangle = Rectangle.new(10,10,15,20)
		@circle = Circle.new(12,12,23)
		@square = Square.new(25,25,40)
	end
	
	def test_save_one_shape
		@load_save.save_diagram([@rectangle])
		
		File.open(@file_name, 'r') do |file|   
			line =  file.gets
			assert_equal("Rectangle 10 10 15 20 ", line.chop)
		end  
	end
	
	def test_save_two_shape
		@load_save.save_diagram([@square, @circle])
		
		File.open(@file_name, 'r') do |file|   
			line =  file.gets
			assert_equal("Square 25 25 40 ", line.chop)
			line =  file.gets
			assert_equal("Circle 12 12 23 ", line.chop)
		end  
	end
	
	def test_save_group_of_three_shapes
		group_shape = Group.new
		group_shape.add_shape(@rectangle)
		group_shape.add_shape(@square)
		group_shape.add_shape(@circle)
		@load_save.save_diagram([group_shape])
		
		File.open(@file_name, 'r') do |file| 
			line = file.gets
			assert_equal("Group", line.chop)
			line =  file.gets
			assert_equal("Rectangle 10 10 15 20 ", line.chop)		
			line =  file.gets
			assert_equal("Square 25 25 40 ", line.chop)
			line =  file.gets
			assert_equal("Circle 12 12 23 ", line.chop)
			line = file.gets
			assert_equal("END Group", line.chop)
		end  
	end
	
	def test_save_group_of_one_shape_and_two_seperate_shapes
		group_shape = Group.new
		group_shape.add_shape(@rectangle)
		@load_save.save_diagram([group_shape, @square, @circle])
		
		File.open(@file_name, 'r') do |file| 
			line = file.gets
			assert_equal("Group", line.chop)
			line =  file.gets
			assert_equal("Rectangle 10 10 15 20 ", line.chop)	
			line = file.gets
			assert_equal("END Group", line.chop)			
			line =  file.gets
			assert_equal("Square 25 25 40 ", line.chop)
			line =  file.gets
			assert_equal("Circle 12 12 23 ", line.chop)

		end  
	end
	
	def test_load_of_shapes_correctly
		@load_save.save_diagram([@square, @circle])
		shapes_loaded = @load_save.load_diagram
		assert_equal(12, shapes_loaded[1].x_pivot)
		assert_equal(12, shapes_loaded[1].y_pivot)
		assert_equal(23, shapes_loaded[1].radius)
		assert_equal(25, shapes_loaded[0].x_pivot)
		assert_equal(25, shapes_loaded[0].y_pivot)
		assert_equal(40, shapes_loaded[0].length)
	end
	
	def test_load_of_group_correctly
		inner_group = Group.new
		inner_group.add_shape(@rectangle)
		inner_group.add_shape(@circle)
		@load_save.save_diagram([inner_group])
		shapes_loaded = @load_save.load_diagram
		assert_equal(1, shapes_loaded.length)
		assert_equal(Group, shapes_loaded[0].class)
	end
	
	def test_load_one_shape_and_group_correctly
		inner_group = Group.new
		inner_group.add_shape(@rectangle)
		inner_group.add_shape(@circle)
		@load_save.save_diagram([@square, inner_group])
		shapes_loaded = @load_save.load_diagram
		assert_equal(2, shapes_loaded.length)
		assert_equal(2, shapes_loaded[1].shapes.length)
	end
	
	def test_load_of_two_groups_and_one_shape
		inner_group1 = Group.new
		inner_group1.add_shape(@rectangle)
		inner_group2 = Group.new
		inner_group2.add_shape(@square)
		@load_save.save_diagram([@circle, inner_group1, inner_group2])
		shapes_loaded = @load_save.load_diagram
		assert_equal(3, shapes_loaded.length)
	end
	
	def test_load_of_group_within_a_group
		inner_group1 = Group.new
		inner_group1.add_shape(@rectangle)
		inner_group2 = Group.new
		inner_group2.add_shape(@square)
		inner_group1.add_shape(inner_group2)
		@load_save.save_diagram([inner_group1])
		shapes_loaded = @load_save.load_diagram
		assert_equal(1, shapes_loaded.length)
		assert_equal(1, shapes_loaded[0].shapes.length)
	end
end