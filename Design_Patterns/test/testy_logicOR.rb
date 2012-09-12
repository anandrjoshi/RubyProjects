require 'test/unit'
require 'logicOR'

class TestLogicOR< Test::Unit::TestCase
	
	def test_canary
		assert(true)
	end
	
	def setup
		@logic_OR = LogicOR.new(2)
	end
	
	def test_length_of_number_of_inputs_in_object
		assert_equal(2, @logic_OR.input_states.length)
	end
	
	def test_input_states_set_to_false
		assert_equal(false, @logic_OR.input_states[1])
	end
	
	def test_true_returned_when_valid_input_state_set
		assert_equal(true, @logic_OR.set_input(1, true))
	end
	
	def test_out_of_bounds_input_set
		assert_equal(false, @logic_OR.set_input(2, true))
	end
	
	def test_actual_value_set_for_input_state
		@logic_OR.set_input(0, true)
		assert_equal(true, @logic_OR.input_states[0])
	end
	
	def test_trigger_with_one_input_state_as_true
		@logic_OR.set_input(0, true)
		assert_equal(true, @logic_OR.trigger)
	end
	
	def test_output_state_value_when_triggered_with_one_input_state_as_true
		@logic_OR.set_input(0, true)
		@logic_OR.trigger
		assert_equal(true, @logic_OR.output_state)
	end
	
	def test_trigger_with_no_input_state_as_true
		assert_equal(false, @logic_OR.trigger)
	end
	
	def test_output_state_value_when_triggered_with_no_input_state_as_true
		@logic_OR.trigger
		assert_equal(false, @logic_OR.output_state)
	end
end