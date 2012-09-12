require 'test/unit'
require 'hangman'

class TestHangmanGame < Test::Unit::TestCase

  def test_canary
    assert(true)
  end

  def setup
   @game = Hangman.new("endeavour")
  end

  def test_correct_letter_guessed_and_displayed_single_occurance
    assert_equal("----a----", @game.guess_letter("a")[1])
  end

  def test_correct_letter_guessed_and_unchanged_errored_attempt
    @game.guess_letter("a")
    assert_equal(0, @game.errored_attempt)
  end

  def test_incorrect_letter_guessed_and_not_displayed
    assert_equal("---------", @game.guess_letter("x")[1])
  end

  def test_incorrect_letter_guessed_and_errored_attampt_increased
    @game.guess_letter("x")
    assert_equal(1, @game.errored_attempt)
  end

  def test_correct_letter_guessed_multiple_occurances   
    assert_equal("e--e-----", @game.guess_letter("e")[1])
  end

  def test_uncovering_of_boundary_letters
    @game.guess_letter("e")
    assert_equal("e--e----r", @game.guess_letter("r")[1])
  end

  def test_case_insensitive_comparison_of_existing_letter
	@game.guess_letter("E")
	@game.guess_letter("E")
	@game.guess_letter("e")
	assert_equal(true, @game.errored_attempt == 0)
  end
  
  def test_case_insensitive_comparison_of_non_existing_letter
	@game.guess_letter("x")
	@game.guess_letter("X")
	@game.guess_letter("x")
	assert_equal(true, @game.errored_attempt == 3)
  end

  def test_word_guessed_correctly_and_game_won
    @game.selected_word.each_char do |c|
      @game.guess_letter(c)
    end
    assert_equal(true, @game.game_over)
  end
  
  def test_word_guessed_incorrectly_with_exactly_six_incorrect_guesses_and_game_lost
    incorrect_letters = "fghijk"
    incorrect_letters.each_char do |c|
      @game.guess_letter(c)
    end
    assert_equal(true, @game.game_over)
  end

  def test_valid_lowercase_letter_guessed
    assert(@game.validate_guessed_letter('a'))
  end

  def test_valid_uppercase_letter_guessed
    assert(@game.validate_guessed_letter('Z'))
  end

  def test_invalid_non_alphabetic_character_guessed
    assert_equal(false, @game.validate_guessed_letter('@'))
  end

  def test_invalid_with_morethan_one_letter_guessed
    assert_equal(false, @game.validate_guessed_letter('AA'))
  end

  def test_invalid_with_no_letter_guessed
    assert_equal(false, @game.validate_guessed_letter(''))
  end

end