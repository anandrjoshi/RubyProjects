require 'rubygame/rect.rb'

module SquareDraw
	def draw(screen, color = [0, 0, 255])
		screen.draw_box([@x_pivot, @y_pivot], [@x_pivot + @length, @y_pivot + @length], color)
	end
end

module SquareUI
	def draw_sidebar(screen, fields, color = [0, 255, 0])
		screen.draw_text("Add Square", 630, 20, color)
		screen.draw_text("X", 690, 80, color)
		screen.draw_box([640, 110], [660, 140], color)
		screen.draw_polygon_s([[655, 120], [655, 130], [645, 125]], color)
		screen.draw_box([670, 110],[720, 140],color)
		screen.draw_text("#{fields[:x]}", 690, 115, color)
		screen.draw_box([730, 110], [750, 140], color)
		screen.draw_polygon_s([[735, 120], [735, 130], [745, 125]], color)
		
		screen.draw_text("Y", 690, 160, color)
		screen.draw_box([640, 190], [660, 220], color)
		screen.draw_polygon_s([[655, 200], [655, 210], [645, 205]], color)
		screen.draw_box([670, 190],[720, 220],color)
		screen.draw_text("#{fields[:y]}", 690, 195, color)
		screen.draw_box([730, 190], [750, 220], color)
		screen.draw_polygon_s([[735, 200], [735, 210], [745, 205]], color)
		
		screen.draw_text("Length", 670, 240, color)
		screen.draw_box([640, 270], [660, 300], color)
		screen.draw_polygon_s([[655, 280], [655, 290], [645, 285]], color)
		screen.draw_box([670, 270],[720, 300],color)
		screen.draw_text("#{fields[:length]}", 690, 275, color)
		screen.draw_box([730, 270], [750, 300], color)
		screen.draw_polygon_s([[735, 280], [735, 290], [745, 285]], color)
		
		screen.draw_box([700, 350], [740, 380], color)
		screen.draw_text("OK", 705, 355, color)
	end
	
	def initialize_temp_variables
		["@fields[:x] = 300", "@fields[:y] = 300", "@fields[:length] = 150"]
	end
	
	def handle_mouse_input(x, y)
		decr_x_button = Rubygame::Rect.new(640, 110, 20, 30)
		incr_x_button = Rubygame::Rect.new(730, 110, 20, 30)
		decr_y_button = Rubygame::Rect.new(640, 190, 20, 30)
		incr_y_button = Rubygame::Rect.new(730, 190, 20, 30)
		decr_len_button = Rubygame::Rect.new(640, 270, 20, 30)
		incr_len_button = Rubygame::Rect.new(730, 270, 20, 30)
		ok_button = Rubygame::Rect.new(700, 350, 40, 30)
		
		if decr_x_button.collide_point?(x, y)
			"@fields[:x] = @fields[:x] == 0 ? 0 : @fields[:x] - 1"
		elsif incr_x_button.collide_point?(x, y)
			"@fields[:x] = @fields[:x] + 1"
		elsif decr_y_button.collide_point?(x, y)
			"@fields[:y] = @fields[:y] == 0 ? 0 : @fields[:y] - 1"
		elsif incr_y_button.collide_point?(x, y)
			"@fields[:y] = @fields[:y] + 1"
		elsif decr_len_button.collide_point?(x, y)
			"@fields[:length] = @fields[:length] == 1 ? 1 : @fields[:length] - 1"
		elsif incr_len_button.collide_point?(x, y)
			"@fields[:length] = @fields[:length] + 1"
		elsif ok_button.collide_point?(x, y)
			"@diagram.add_shape(Square.new(@fields[:x], @fields[:y], @fields[:length]))
			status[\"add_shape\"] = false
			status[\"view_default\"] = true"
		else
			""
		end
	end
end