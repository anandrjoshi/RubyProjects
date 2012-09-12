require 'logicOR'
require 'gate'

class LogicORClassAdapter < LogicOR
	include Gate
	
	def initialize
		super(2)
	end
	
	def first_input(value)
		set_input(0, value)
	end
	
	def second_input(value)
		set_input(1, value)
	end
	
	def output
		trigger
		output_state
	end
end