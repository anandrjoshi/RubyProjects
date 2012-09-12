SDL_PATHS = ["#{Dir.pwd}/src/lib"]
ENV['PATH'] += ";#{Dir.pwd}/src/lib/"
require 'rubygame'
include Rubygame

TTF.setup
$arial_narrow_20 = TTF.new "ArialN.ttf", 20

class Painter
	attr_accessor :screen

	def initialize(width, height)
		@screen = Screen.open [width, height]
	end

	def clear
		@screen.draw_box_s([0,0],[@screen.width, @screen.height],[0x00, 0x00, 0x00])
	end

	def draw_line(coord1, coord2, color)
		@screen.draw_line(coord1, coord2, color)
	end

	def draw_box(topleft, bottomright, color)
		@screen.draw_box(topleft, bottomright, color)
	end
	
	def draw_circle(center, radius, color)
		@screen.draw_circle(center, radius, color)
	end
	
	def draw_polygon(list_of_points, color)
		@screen.draw_polygon(list_of_points, color)
	end
	
	def draw_polygon_s(list_of_points, color)
		@screen.draw_polygon_s(list_of_points, color)
	end
	
	def draw_text(text, x, y, color)
		text_buffer = $arial_narrow_20.render_utf8 text, true, color
		text_rect = text_buffer.make_rect
		text_rect.topleft = [x, y]
		text_buffer.blit @screen, text_rect
	end
	
	def flip
		@screen.flip
	end
end