require 'test/unit'
require 'hangman'

class GradingTest < Test::Unit::TestCase
  
  def test_create_hangman
    assert !is_game_over
  end

  def test_make_a_correct_guess
    assert_equal "-n-----", make_a_guess('n')
  end

  def test_make_a_wrong_guess
    assert_equal "-------", make_a_guess('z')
  end

  def test_make_a_second_guess
    make_a_guess('n')
    assert_equal("-n-t---", make_a_guess('t'))
  end

  def test_guessA_letterThatAppearsMoreThanOnce
    assert_equal("i-i-i--", make_a_guess('i'))
  end

  def test_guessANumberInsteadOfA_letter
    assert_raise { make_a_guess('2') }
  end

  def test_make_a_correct_uppercase_letter_guess
    assert_equal("-n-----", make_a_guess('N'))
  end

  def test_number_of_tries_after_a_wrong_guess
    make_a_guess('z')
    assert_equal(@MAX_NUMBER_OF_TRIES - 1, get_number_of_tries_left)
  end

  def test_number_of_tries_afterARight_guess
    make_a_guess('i')
    assert_equal(@MAX_NUMBER_OF_TRIES, get_number_of_tries_left)
  end

  def test_number_of_tries_after_a_secondWrong_guess
    make_a_guess('z')
    make_a_guess('w')
    assert_equal(@MAX_NUMBER_OF_TRIES - 2, get_number_of_tries_left)
  end

  def test_number_of_tries_after_guessingAlready_guessed_letter 
    make_a_guess('t')
    make_a_guess('t')
    assert_equal(@MAX_NUMBER_OF_TRIES, get_number_of_tries_left)
  end

  def test_number_of_tries_after_guessingAlready_guessedWrong_letter 
    make_a_guess('z')
    make_a_guess('z')
    assert_equal(@MAX_NUMBER_OF_TRIES - 1, get_number_of_tries_left)
  end

  def test_number_of_tries_after_guessingAlready_guessedWrong_letterDifferentCase 
    make_a_guess('z')
    make_a_guess('Z')
    assert_equal(@MAX_NUMBER_OF_TRIES - 1, get_number_of_tries_left)
  end

  def test_guess_the_word 
    make_a_guess('n')
    make_a_guess('t')
    make_a_guess('i')
    make_a_guess('l')
    assert_equal("initial", make_a_guess('a'))
    assert(is_game_over)
  end

  def testExhaustTries 
    make_incorrect_guesses
    assert_equal(0, get_number_of_tries_left)
  end

  def test_guessAfterAWin 
    make_a_guess('n')
    make_a_guess('t')
    make_a_guess('i')
    make_a_guess('l')
    make_a_guess('a')

    assert_raise { make_a_guess('i') }
  end

  def make_incorrect_guesses 
    make_a_guess('z')
    make_a_guess('b')
    make_a_guess('c')
    make_a_guess('m')
    make_a_guess('d')
    make_a_guess('w')
  end

  def test_guessAfterALoss 
    make_incorrect_guesses

    assert_raise { make_a_guess('i') }
  end

  def testStartAnotherGame 
    assert_equal("---", start_a_new_game_make_a_wrong_guess("ace", 'w'))
  end

  #------------ Mapping functions to code written by students -------


  def setup 
    @MAX_NUMBER_OF_TRIES = 6
    @hangman = Hangman.new("initial")
  end


  def is_game_over 
    @hangman.game_over
  end

  def make_a_guess(guess_letter) 
    @hangman.guess_letter(guess_letter)[1]
  end

  def get_number_of_tries_left 
    @MAX_NUMBER_OF_TRIES - @hangman.errored_attempt
  end

  def start_a_new_game_make_a_wrong_guess(initial_word, initial_guess) 
    anotherHangman = Hangman.new(initial_word)
    anotherHangman.guess_letter(initial_guess)[1]
  end
end
