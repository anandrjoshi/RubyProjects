require 'cairo'
def linear_gradient(x1,y1,x2,y2,extend,*stops)
  g = Cairo::LinearPattern.new(x1,y1,x2,y2) # endpoints of the line
  g.set_extend(eval("Cairo::EXTEND_#{extend.to_s.upcase}")) #Specify the mode to use when drawing the area outside the pattern. 
  stops.each {|s| g.add_color_stop_rgba(*s)}
  g
end

def path cr, *pairs
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

def cairo_image_surface(w,h,bg=nil)
  surface = Cairo::ImageSurface.new(w,h) # creates canvas for the image
  cr = Cairo::Context.new(surface)
  if bg
    cr.set_source_rgba(*bg) #sets the background to sent value
    cr.paint				# defaults to 0 where this decides the opacity of the picture
  end
  yield(cr)
end

h = 500		  # height of the image
w = h*2    # width of the image
lw = 1       # distance between the two lines that mark the boundary of the triangle
red    = [1.0,0.0,0.0, 1]
lred   = [1.0,0.3,0.3, 1]
black  = [0.0,0.0,0.0, 1]
white  = [1.0,1.0,1.0, 1]
owhite = [1.0,0.95,0.9, 1]
yellow = [1.0,1.0,0.6, 1]
grey   = [0.5,0.5,0.5,1]

cairo_image_surface(w+(lw*2),h+(lw*2), white) do |cr|

  rg1 = linear_gradient(w*0.1,w*0.1,0,0, :pad, [1.0,red],[1.0,red])
  rg2 = linear_gradient(w*0.1,w*0.1,0,0, :pad, [1.0,black],[1.0,black])
  #rg2 = linear_gradient(w*0.2,w*0.3,0,0, :pad, [1.0,red],  [1.0,red])
  # bg1 = linear_gradient(w*0.3,w*0.4,0,0, :reflect, [0.4,grey], [1.0,black])
  # bg2 = linear_gradient(w*0.4,w*0.5,0,0, :reflect, [0.2,grey], [0.8,black])
  
 # cr.set_line_join(Cairo::LINE_JOIN_ROUND)
 # cr.set_line_cap(Cairo::LINE_CAP_ROUND)
 # cr.translate(lw,lw)
  path(cr,[0.25*w,0.25*h],[0.25*w,0.75*h],[0.75*w,0.75*h],[0.75*w,0.25*h],:c)
  
   # We want to draw with the gradient "rg1"
  cr.set_source(rg1)               
  cr.set_line_width(lw*1.5) #width of the boundary for the shape   
  # stroke_preserve draws without clearing the path afterwards
  cr.stroke      

  path(cr,[0.15*w,0.15*h],[0.15*w,0.85*h],[0.85*w,0.85*h],[0.85*w,0.15*h],:c)
  
  # We want to draw with the gradient "rg1"
  cr.set_source(rg2)               
  cr.set_line_width(lw*5.0) #width of the boundary for the shape   
  # stroke_preserve draws without clearing the path afterwards
  cr.stroke 
  
  #... because we want to use it again, with gradient 'rg2'
  # cr.set_source(rg2)               
  # cr.set_line_width(lw)
  # cr.stroke
  
  # this part creates an exclamation mark.
  # path(cr,[w*0.45,h*0.5],[w*0.55,h*0.5],[w/2,h*0.68],:c,
	  # [w*0.48,h*0.8],[w*0.52,h*0.8],[w*0.515,h*0.82],
          # [w*0.485,h*0.82],:c)
  # # This does more or less the same as above,
  # # but notice how it fills to, to make sure the
  # # interior of the exclamation mark is filled in too

  # cr.set_line_width(lw*0.6)
  # cr.set_source(bg2)
  # cr.fill_preserve
  # cr.stroke_preserve

  # cr.set_source(bg1)
  # cr.set_line_width(lw*0.4)
  # cr.fill_preserve
  # cr.stroke
  cr.target.write_to_png("test.png")
end
  

	