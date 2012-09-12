require 'test/unit'
require "../src/hangman.rb"

class TestHangmanGame < Test::Unit::TestCase

	def test_canary
    assert_equal(true, true)
  end
  
  def setup
   @word_selected = "Endeavour"
  end

  def test_word_displayed_as_asterix
    game = Hangman.new(@word_selected)
    assert_equal(game.get_original_word_as_array.length, @word_selected.length)
    assert_equal(game.get_word_array_as_asterix.length, @word_selected.length)
  end

  def test_successful_attempt_by_user
    game = Hangman.new(@word_selected)
    game.attempt_by_user("e")
    assert_equal(game.get_errored_attempts, 0)
    word_as_asterix = game.get_word_array_as_asterix
    assert_equal(word_as_asterix[0],"E")
    assert_equal(word_as_asterix[3],"e")
  end

  def test_failed_attempt_by_user
    game = Hangman.new(@word_selected)
    game.attempt_by_user("x")
    assert_equal(game.get_errored_attempts, 1)
    word_as_asterix = game.get_word_array_as_asterix
    assert_equal(word_as_asterix,["*","*","*","*","*","*","*","*","*"])
  end

  def test_reuse_of_same_letter_attempt_by_user
    game = Hangman.new(@word_selected)
    game.attempt_by_user("e")
    assert_equal(game.get_errored_attempts, 0)
    game.attempt_by_user("E")
    assert_equal(game.get_errored_attempts, 0)
    game.attempt_by_user("e")
    assert_equal(game.get_errored_attempts, 0)
  end

  def test_successful_unveiling_of_entire_word
    game = Hangman.new(@word_selected)
    game.attempt_by_user("e")
    game.attempt_by_user("n")
    game.attempt_by_user("d")
    game.attempt_by_user("e")
    game.attempt_by_user("a")
    game.attempt_by_user("v")
    game.attempt_by_user("o")
    game.attempt_by_user("u")
    game.attempt_by_user("r")
    
    word_as_asterix = game.get_word_array_as_asterix
    original_word_array = game.get_original_word_as_array
    assert_equal(word_as_asterix, original_word_array)
  end
  
end