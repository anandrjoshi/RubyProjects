class Hangman
  
  attr_reader :selected_word, :errored_attempt, :word_as_asterix
  
  def initialize(selected_word)
    @selected_word = selected_word.downcase
    @errored_attempt = 0
    @word_as_asterix = ""
    @selected_word.length.times do
      @word_as_asterix << "-"
    end
  end

  def guess_letter(guessed_letter)
    status = "Attempt Successful"
    if !@selected_word.include?(guessed_letter.downcase)
      @errored_attempt = @errored_attempt + 1
      status = "#{guessed_letter} not in the word."
    elsif @word_as_asterix.include?(guessed_letter)
        status = "#{guessed_letter} already uncovered."
    else
        for index_in_word in 0...@selected_word.length
          @word_as_asterix[index_in_word] = @selected_word[index_in_word].chr unless guessed_letter != @selected_word[index_in_word].chr
        end
    end
    return status, @word_as_asterix
  end

  def game_over
    (@selected_word == @word_as_asterix or @errored_attempt >= 6)
  end

  def validate_guessed_letter(guessed_letter)
    (guessed_letter.length == 1 and !!guessed_letter.match(/\A(^[a-zA-Z])\Z/i))
  end
end