require './src/diagram.rb'
require './src/rectangle.rb'
require './src/square.rb'
require './src/circle.rb'
require './src/group.rb'
require './src/ui/painter.rb'

$BLUE = [0, 0, 255]
$RED = [255, 0, 0]
$GREEN = [0, 255, 0]
$YELLOW = [255, 255, 0]

def populate_view_default_tab(screen)
	screen.draw_text("Add Shape", 630, 20, $YELLOW)
	
	new_shape_class = @available_shapes[@index_for_add_shape]
	screen.draw_text(new_shape_class.to_s, 625, 55, $YELLOW)
	screen.draw_box([625, 50], [725, 80], $YELLOW)
	
	screen.draw_box([730, 50], [750, 80],$YELLOW)
	screen.draw_polygon_s([[735, 60], [735, 70], [745, 65]], $YELLOW)
	
	screen.draw_text("OK", 665, 95, $YELLOW)
	screen.draw_box([660, 90], [700, 120], $YELLOW)
	
	screen.draw_text("Select Shape", 630, 150, $YELLOW)
	
	screen.draw_box([625, 180], [750, 210], $YELLOW)
	selected_shape_s = @diagram.list_of_shapes.empty? ? "N/A" : "[#{@index_of_active_object}] : #{@diagram.list_of_shapes[@index_of_active_object].class}"
	screen.draw_text(selected_shape_s, 625, 185, $YELLOW)
	
	screen.draw_box([755, 180], [775, 210], $YELLOW)
	screen.draw_polygon_s([[760, 190], [760, 200], [770, 195]], $YELLOW)
	
	screen.draw_text("OK", 665, 225, $YELLOW)
	screen.draw_box([660, 220], [700, 250], $YELLOW)
	
	screen.draw_text("Load File", 630, 285, $YELLOW)
	screen.draw_box([625, 280], [725, 310], $YELLOW)
	
	screen.draw_text("Save File", 630, 345, $YELLOW)
	screen.draw_box([625, 340], [725, 370], $YELLOW)
	
	if @error_message.length > 0
		screen.draw_text(@error_message, 0, 570, $YELLOW)
	end
end

def populate_selected_shape_tab(screen)
	screen.draw_text("Move Shape(s)", 630, 60, $GREEN)
	screen.draw_box([625, 55], [750, 85], $GREEN)
	
	screen.draw_text("Delete", 630, 180, $GREEN)
	screen.draw_box([625, 175], [725, 205], $GREEN)
	
	screen.draw_text("Add to Group", 630, 300, $GREEN)
	screen.draw_box([625, 295], [750, 325], $GREEN)
	
	if @diagram.list_of_shapes[@index_of_active_object].instance_of? Group
		screen.draw_text("Ungroup", 630, 420, $GREEN)
		screen.draw_box([625, 415], [725, 445], $GREEN)
	end
end

def populate_file_io_tab(screen, status)
	screen.draw_text( (status["load"] ? "Load File" : "Save File") , 640, 80, $GREEN)
	
	screen.draw_text("Type in file name: ", 620, 150, $GREEN)
	screen.draw_box([625, 180], [750, 210], $GREEN)
	screen.draw_text(@io_file_name, 630, 185, $GREEN) if @io_file_name.length > 0

	screen.draw_text("OK", 665, 225, $GREEN)
	screen.draw_box([660, 220], [700, 250], $GREEN)
end

def populate_move_by_tab(screen)
	screen.draw_text("Move Shape", 640, 80, $RED)
	
	screen.draw_box([670, 150], [700, 170], $RED)
	screen.draw_polygon_s([[680, 165], [690, 165], [685, 155]], $RED)
	
	screen.draw_box([640, 180], [660, 210], $RED)
	screen.draw_polygon_s([[645, 195], [655, 190], [655, 200]], $RED)
	
	screen.draw_box([670, 220], [700, 240], $RED)
	screen.draw_polygon_s([[680, 225], [685, 235], [690, 225]], $RED)
	
	screen.draw_box([710, 180], [730, 210], $RED)
	screen.draw_polygon_s([[715, 190], [715, 200], [725, 195]], $RED)
	
	screen.draw_text("X: #{@move_x}", 640, 260, $RED)
	screen.draw_text("Y: #{@move_y}", 700, 260, $RED)
	
	screen.draw_text("OK", 680, 300, $RED)
	screen.draw_box([675, 295], [715, 325], $RED)
end

def populate_add_to_group_tab(screen)
	screen.draw_text("Select Group", 630, 150, $RED)
	
	screen.draw_box([625, 180], [725, 210], $RED)
	selected_group_s = @existing_groups.empty? ? "N/A" : "Group [#{@index_for_add_to_group}]"
	screen.draw_text(selected_group_s, 625, 185, $RED)
	
	screen.draw_box([730, 180], [750, 210], $RED)
	screen.draw_polygon_s([[735, 190], [735, 200], [745, 195]], $RED)
	
	screen.draw_text("OK", 665, 225, $RED)
	screen.draw_box([660, 220], [700, 250], $RED)
	
	screen.draw_text("+ New Group", 630, 290, $RED)
	screen.draw_box([625, 285], [750, 315], $RED)
end

def draw_sidebar(screen, status)
	if status["view_default"]
		populate_view_default_tab(screen)
	elsif status["add_shape"]
		@available_shapes[@index_for_add_shape]::draw_sidebar(screen, @fields)
	elsif status["selected_shape"]
		populate_selected_shape_tab(screen)
	elsif status["load"] or status["save"]
		populate_file_io_tab(screen, status)
	elsif status["move_by"]
		populate_move_by_tab(screen)
	elsif status["add_to_group"]
		populate_add_to_group_tab(screen)
	end
end

@diagram = Diagram.new
screen = Painter.new(800, 600)

status = {	"view_default" => true,
			"add_shape" => false,
			"selected_shape" => false,
			"load" => false,
			"save" => false,
			"move_by" => false,
			"add_to_group" => false	}
@available_shapes = Shape::descendants			
@index_for_add_shape = 0
@index_of_active_object = 0
@error_message = ""

@event_queue = EventQueue.new
@event_queue.enable_new_style_events
while true
	screen.clear
	@diagram.list_of_shapes.each_with_index do |shape,index|
		color = index == @index_of_active_object ? $RED :
			( (status["add_to_group"] and shape == @existing_groups[@index_for_add_to_group]) ? $GREEN : $BLUE )
		shape.draw(screen, color)
	end
	draw_sidebar(screen, status)
	screen.draw_text("Press ESC to exit", 0, 0, $YELLOW)
	screen.draw_text("Hover over button and use mouse wheel to speed up selection", 0, 25, $GREEN)
	screen.draw_line([600, 0], [600, 600], $YELLOW)
	screen.flip
	
	until !(event_fired = @event_queue.wait()).nil?
	end

	if event_fired.is_a? Events::KeyPressed
		break if event_fired.key == :escape
		if status["load"] or status["save"]
			if event_fired.key == :backspace
				@io_file_name = @io_file_name.chop
			elsif event_fired.string.length > 0 and event_fired.key != :return and event_fired.key != :tab
				@io_file_name += event_fired.string
			end
		end
	elsif event_fired.is_a? Events::MousePressed
		x = event_fired.pos[0]
		y = event_fired.pos[1]
		@error_message = "" if !status["view_default"]
		
		if status["view_default"]
			add_ok_button = Rect.new(660, 90, 40, 30)
			add_next_button = Rect.new(730, 50, 20, 30)
			select_next_button = Rect.new(755, 180, 20, 30)
			select_ok_button = Rect.new(660, 220, 40, 30)
			load_button = Rect.new(625, 280, 100, 30)
			save_button = Rect.new(625, 340, 100, 30)
			
			if add_next_button.collide_point?(x,y)
				@index_for_add_shape = @index_for_add_shape == @available_shapes.length - 1 ? 0 : @index_for_add_shape + 1
				
			elsif add_ok_button.collide_point?(x,y)
				@fields = {}
				@available_shapes[@index_for_add_shape]::initialize_temp_variables.each { |stmt| eval(stmt) }
				status["view_default"] = false
				status["add_shape"] = true
				
			elsif select_next_button.collide_point?(x,y) and not @diagram.list_of_shapes.empty?
				@index_of_active_object = @index_of_active_object == @diagram.list_of_shapes.length - 1 ? 0 : @index_of_active_object + 1
				
			elsif select_ok_button.collide_point?(x,y) and not @diagram.list_of_shapes.empty?
				status["view_default"] = false
				status["selected_shape"] = true
			
			elsif load_button.collide_point?(x,y)
				@io_file_name = ""
				status["view_default"] = false
				status["load"] = true
				
			elsif save_button.collide_point?(x,y)
				@io_file_name = ""
				status["view_default"] = false
				status["save"] = true
			end
			
		elsif status["add_shape"]
			eval(@available_shapes[@index_for_add_shape]::handle_mouse_input(x, y))
			
		elsif status["selected_shape"]
			move_button = Rect.new(625, 55, 125, 30)
			delete_button = Rect.new(625, 175, 100, 30)
			add_to_group_button = Rect.new(625, 295, 125, 30)
			ungroup_button = Rect.new(625, 415, 100, 30)
			
			if move_button.collide_point?(x,y)
				@move_x = 0
				@move_y = 0
				status["selected_shape"] = false
				status["move_by"] = true
				
			elsif delete_button.collide_point?(x,y)
				@diagram.delete_shape(@diagram.list_of_shapes[@index_of_active_object])
				@index_of_active_object = 0
				status["selected_shape"] = false
				status["view_default"] = true
				
			elsif add_to_group_button.collide_point?(x,y)
				@existing_groups = @diagram.list_of_shapes.select {|obj| obj != @diagram.list_of_shapes[@index_of_active_object] and obj.instance_of? Group}
				@index_for_add_to_group = 0
				status["selected_shape"] = false
				status["add_to_group"] = true
				
			elsif ungroup_button.collide_point?(x,y) and @diagram.list_of_shapes[@index_of_active_object].instance_of? Group
				@diagram.list_of_shapes.concat(@diagram.list_of_shapes[@index_of_active_object].shapes)
				@diagram.delete_shape(@diagram.list_of_shapes[@index_of_active_object])
				status["selected_shape"] = false
				status["view_default"] = true
			end
		elsif status["load"]
			ok_button = Rect.new(660, 220, 40, 30)
			
			if ok_button.collide_point?(x,y)
				begin
					@diagram = Diagram::load_diagram(@io_file_name)
				rescue
					@error_message = "Error occurred while loading file. Check that file exists and is not corrupted."
				end
				status["load"] = false
				status["view_default"] = true
			end
		elsif status["save"]
			ok_button = Rect.new(660, 220, 40, 30)
			
			if ok_button.collide_point?(x,y)
				@diagram.save_diagram(@io_file_name)
				status["save"] = false
				status["view_default"] = true
			end
		elsif status["move_by"]
			decr_x_button = Rect.new(640, 180, 20, 30)
			incr_x_button = Rect.new(710, 180, 20, 30)
			decr_y_button = Rect.new(670, 150, 30, 20)
			incr_y_button = Rect.new(670, 220, 30, 20)
			ok_button = Rect.new(675, 295, 40, 30)
			
			if decr_x_button.collide_point?(x,y)
				@move_x = @move_x - 1
			elsif incr_x_button.collide_point?(x,y)
				@move_x = @move_x + 1
			elsif decr_y_button.collide_point?(x,y)
				@move_y = @move_y - 1
			elsif incr_y_button.collide_point?(x,y)
				@move_y = @move_y + 1
			elsif ok_button.collide_point?(x,y)
				@diagram.list_of_shapes[@index_of_active_object].move_shape_by(@move_x, @move_y)
				status["move_by"] = false
				status["view_default"] = true
			end
		elsif status["add_to_group"]
			group_next_button = Rect.new(730, 180, 20, 30)
			group_ok_button = Rect.new(660, 220, 40, 30)
			new_group_button = Rect.new(625, 285, 125, 30)
			
			if group_next_button.collide_point?(x,y)
				@index_for_add_to_group = @index_for_add_to_group == @existing_groups.length - 1 ? 0 : @index_for_add_to_group + 1
			elsif group_ok_button.collide_point?(x,y) and not @existing_groups.empty?
				@existing_groups[@index_for_add_to_group].add_shape(@diagram.list_of_shapes[@index_of_active_object])
				@diagram.delete_shape(@diagram.list_of_shapes[@index_of_active_object])
				@index_of_active_object = 0
				status["add_to_group"] = false
				status["view_default"] = true
			elsif new_group_button.collide_point?(x,y)
				new_group = Group.new
				new_group.add_shape(@diagram.list_of_shapes[@index_of_active_object])
				@diagram.delete_shape(@diagram.list_of_shapes[@index_of_active_object])
				@diagram.add_shape(new_group)
				status["add_to_group"] = false
				status["view_default"] = true
			end
		end
	end
end
