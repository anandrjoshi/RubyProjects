require 'test/unit'
require './TestHangmanDisplay.rb'

class HangmanDisplay_Test < Test::Unit::TestCase
  # def setup
  # end

  # def teardown
  # end

  def Test_Canary
	assert(true)
  end
  
  def Test_DisplayLevel0Hangman
	assert_equal(1, DispLevel0Man(), 'Asserting not equal')
  end
  
  def Test_DisplayLevel1Hangman
	DispLevel1Man()
  end
  
  def Test_DisplayLevel2Hangman
	DispLevel2Man()
  end
  
  def Test_DisplayLevel3Hangman
	DispLevel3Man()
  end
  
  def Test_DisplayLevel4Hangman
	DispLevel4Man()
  end
  
  def Test_DisplayLevel5Hangman
	DispLevel5Man()
  end
  
  def Test_DisplayLevel6Hangman
	DispLevel6Man()
  end
end