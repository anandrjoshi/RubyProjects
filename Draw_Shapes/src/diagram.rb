require './src/group.rb'
require './src/shape.rb'

class Diagram
	attr_accessor :list_of_shapes
	
	def initialize(existing_shapes = [])
		@list_of_shapes = existing_shapes
	end
	
	def add_shape(shape)
		raise "Shape already belongs to this diagram. So cannot add it again." if @list_of_shapes.include?(shape)
		@list_of_shapes << shape
	end
	
	def delete_shape(shape)
		raise "Shape does not belong in this diagram. So cannot delete it." if !@list_of_shapes.include?(shape)
		@list_of_shapes.delete(shape)
	end
	
	def save_diagram(file_name)
		File.open(file_name, 'w') do |file| 
			begin
				Marshal.dump(self, file)	
			ensure
				file.close
			end
		end
	end
	
	def self.load_diagram(file_name)
		begin
			File.open(file_name,"r") {|f| Marshal.load(f)}
		rescue Exception
			raise "Error occured while reading file. Check if the file exists or for its contents."
		end	
	end
end
