require 'logicOR'
require 'gate'

class LogicORObjectAdapter 
	include Gate
	
	attr_accessor :logicOR
	
	def initialize (logicOR)
		@logicOR = logicOR
		raise "Logic OR has less than two inputs" if !@logicOR.set_input(1, true)
		raise "Logic OR has more than two inputs" if @logicOR.set_input(2, true)
	end
	
	def first_input(value)
		@logicOR.set_input(0, value)
	end
	
	def second_input(value)
		@logicOR.set_input(1, value)
	end
	
	def output
		@logicOR.trigger
		@logicOR.output_state
	end
end
	
	