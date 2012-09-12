require 'test/unit'
require 'logicOR'
require 'logicOR_object_adapter'
require 'test_exercise_logicOR'

class TestLogicORObjectAdapter < Test::Unit::TestCase 

	include TestExerciseLogicOR
	
	def self.get_adapter
		LogicORObjectAdapter.new(LogicOR.new(2))
	end
	
	def test_logic_or_has_less_than_two_inputs
		assert_raise(RuntimeError){adapter = LogicORObjectAdapter.new(LogicOR.new(1))}
	end
	
	def test_logic_or_has_more_than_two_inputs
		assert_raise(RuntimeError){adapter = LogicORObjectAdapter.new(LogicOR.new(3))}
	end
end