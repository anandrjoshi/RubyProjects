class Hangman
  
  def initialize(selected_word)
    @selected_word = selected_word
    @errored_attempt = 0
    @original_word_array, @word_as_asterix = blankout_selected_word(selected_word)
  end

  def get_selected_word
    @selected_word
  end

  def get_errored_attempts
    @errored_attempt
  end

  def get_original_word_as_array
    @original_word_array
  end

  def get_word_array_as_asterix
    @word_as_asterix
  end

  def blankout_selected_word(word_selected)
    word_split_as_char_array = word_selected.split(//)
    word_as_asterix = Array.new(word_split_as_char_array.length)
    word_as_asterix.length.times{|count| word_as_asterix[count] = '*'}
    return word_split_as_char_array, word_as_asterix
  end

  def attempt_by_user(guessed_letter)
    found_in_this_attempt = false
    index_in_array = 0

    if check_if_letter_already_guessed(guessed_letter)
       puts "Letter already uncovered."
    else
      for index_in_array in 0...@original_word_array.length
        if guessed_letter.downcase == @original_word_array[index_in_array] or
           guessed_letter.upcase == @original_word_array[index_in_array]
              found_in_this_attempt = true
              @word_as_asterix[index_in_array] = @original_word_array[index_in_array]
        end
      end
      unless found_in_this_attempt
        puts "#{guessed_letter} not in the word"
        @errored_attempt = @errored_attempt + 1
      end
    end
  end

  def check_if_letter_already_guessed(guessed_letter)
    return @word_as_asterix.include?(guessed_letter)
  end

end
