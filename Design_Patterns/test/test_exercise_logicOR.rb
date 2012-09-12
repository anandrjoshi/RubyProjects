require 'test/unit'

module TestExerciseLogicOR 
	
	def get_adapter
		self.class.get_adapter
	end
	
	def test_logicOR_with_both_false_inputs 
		adapter = get_adapter
		adapter.first_input(false)
		adapter.second_input(false)
		assert(!adapter.output)
	end
	
	def test_logicOR_with_first_false_second_true 
		adapter = get_adapter
		adapter.first_input(false)
		adapter.second_input(true)
		assert(adapter.output)
	end
	
	def test_logicOR_with_first_true_second_false 
		adapter = get_adapter
		adapter.first_input(true)
		adapter.second_input(false)
		assert(adapter.output)
	end
	
	def test_logicOR_with_both_true_inputs 
		adapter = get_adapter
		adapter.first_input(true)
		adapter.second_input(true)
		assert(adapter.output)
	end
end
