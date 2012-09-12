module GroupDraw
	def draw(screen, color = [0, 0, 255])
		@shapes.each { |shape| shape.draw(screen, color) }
	end
end