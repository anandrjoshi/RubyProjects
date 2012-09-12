class LogicOR
	attr_accessor :number_of_inputs, :input_states, :output_state
	
	def initialize(number_of_inputs)
		@number_of_inputs = number_of_inputs
		@input_states = Array.new(number_of_inputs, false)
		@output_state = false
	end
	
	def set_input(index, value)
		return false if index >= @number_of_inputs
		@input_states[index] = value
		true
	end
	
	def trigger
		@output_state = false
		@output_state = true if @input_states.include?(true)
	end

end