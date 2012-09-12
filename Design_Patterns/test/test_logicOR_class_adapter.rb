require 'test/unit'
require 'logicOR_class_adapter'
require 'test_exercise_logicOR'

class TestLogicORClassAdapter < Test::Unit::TestCase 

	include TestExerciseLogicOR
	
	def test_canary
		assert(true)
	end
	
	def self.get_adapter
		LogicORClassAdapter.new
	end
end