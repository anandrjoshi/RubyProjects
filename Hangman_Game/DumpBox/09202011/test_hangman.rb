require 'test/unit'
require 'hangman'

class TestHangman < Test::Unit::TestCase

  def test_canary
    assert(true)
  end

  def setup
   @game = Hangman.new("Endeavour")
  end

  def test_word_set_correctly_to_object
    assert_equal(@game.get_selected_word, "Endeavour")
  end

  def test_word_asterixed_correctly
    assert_equal(@game.get_word_array_as_asterix.length, "Endeavour".length)
  end

  def test_word_parsed_correctly_into_array
    assert_equal(@game.get_original_word_as_array.length, "Endeavour".length)
  end

  def test_correct_letter_guessed_single_occurance
    @game.attempt_by_user("a")
    assert_equal(@game.get_word_array_as_asterix.join,"****a****")
    assert_equal(@game.get_errored_attempts,0)
  end

  def test_incorrect_letter_guessed
    @game.attempt_by_user("x")
    assert_equal(@game.get_word_array_as_asterix.join,"*********")
    assert_equal(@game.get_errored_attempts,1)
  end

  def test_correct_letter_guessed_multiple_occurances
    @game.attempt_by_user("e")
    assert_equal(@game.get_word_array_as_asterix.join,"E**e*****")
    assert_equal(@game.get_errored_attempts,0)
  end

  def test_three_errored_attempts
    @game.attempt_by_user("x")
    @game.attempt_by_user("l")
    @game.attempt_by_user("p")
    assert_equal(@game.get_word_array_as_asterix.join,"*********")
    assert_equal(@game.get_errored_attempts,3)
  end

  def test_uncovering_of_boundary_letters
    @game.attempt_by_user("e")
    @game.attempt_by_user("r")
    assert_equal(@game.get_word_array_as_asterix.join,"E**e****r")
  end

  def test_letter_already_guessed
    @game.attempt_by_user("e")
    @game.attempt_by_user("e")
    assert_equal(@game.check_if_letter_already_guessed("e"), true)
  end
end
