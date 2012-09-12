require 'cairo'
def linear_gradient(x1,y1,x2,y2,extend,*stops)
  g = Cairo::LinearPattern.new(x1,y1,x2,y2) 
  stops.each {|s| g.add_color_stop_rgba(*s)}
  g
end

def radial_gradient(x1,y1,r1,x2,y2,r2,*stops)
	r = Cairo::RadialPattern.new(x1,y1,r1,x2,y2,r2)
	stops.each {|s| r.add_color_stop_rgba(*s)}
	r
end

def draw_linear_shape cr, *pairs
  first = true
  pairs.each do |cmd| 
    if cmd == :c
		cr.close_path
		first = true
    elsif first
		cr.move_to(*cmd)
		first = false
    else
		cr.line_to(*cmd)
    end	
  end
end

def draw_circular_shape cr, *pairs
	first = true
	x1 = 0;
	y1 = 0
	pairs.each do |cmd|
		if cmd == :c
			cr.close_path
			first = true
		elsif first
			x1 = cmd[0]
			y1 = cmd[1]
			first = false
		else	
			cr.arc(x1, y1, cmd[0], cmd[1], cmd[2])
		end
	end
end	
		
def cairo_image_surface(w,h,bg=nil)
  surface = Cairo::ImageSurface.new(w,h) 
  cr = Cairo::Context.new(surface)
  if bg
    cr.set_source_rgba(*bg) 
    cr.paint				
  end
  yield(cr)
end

h = 500		  
w = h*2    
lw = 1       
red    = Cairo::Color::RED
black  = Cairo::Color::BLACK
white  = Cairo::Color::WHITE
orange = Cairo::Color::ORANGE
green  = Cairo::Color::GREEN
blue   = Cairo::Color::BLUE

cairo_image_surface(w+(lw*2),h+(lw*2), white) do |cr|

  line_bit_1 = linear_gradient(w*0.1,w*0.1,0,0, [1.0,red],[1.0,red])
  line_bit_2 = linear_gradient(w*0.1,w*0.1,0,0, [1.0,green],[1.0,green])
  line_bit_3 = linear_gradient(w*0.1,w*0.1,0,0, [1.0,orange],[1.0,orange])


  draw_linear_shape(cr,[20,20],[37.33,30],[27.33, 47.33],[10, 37.33],:c)
  
   
  cr.set_source(line_bit_1)               
  cr.set_line_width(lw*1.5) 
  cr.stroke      

  draw_linear_shape(cr,[0.15*w,0.15*h],[0.15*w,0.85*h],[0.85*w,0.85*h],[0.85*w,0.15*h],:c)
  
  
  cr.set_source(line_bit_2)               
  cr.set_line_width(lw*5.0) 
  cr.stroke 
  
  draw_linear_shape(cr,[0.33*w, 0.66*h],[0.5*w, 0.2*h],[0.66*w, 0.66*h],:c)
  
  cr.set_source(line_bit_3)               
  cr.set_line_width(lw*5.0)   
  cr.stroke 
  
  radial_bit_1 = radial_gradient(w*0.1, w*0.1, 0, 0, 0, h*0.3, [1.0,blue],[1.0,blue])
  
  draw_circular_shape(cr, [w*0.5, h*0.5], [0.25*h, 0, 2 * Math:: PI], :c)
  
  cr.set_source(radial_bit_1)               
  cr.set_line_width(lw*5.0) 
  cr.stroke
  
  
  cr.target.write_to_png("test2.png")
end
  

	