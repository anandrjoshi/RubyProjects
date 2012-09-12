require 'rubygems'
require 'sqlite3'
require 'active_record'
require 'active_support/inflector'
require "./Word_Class.rb"
require "./Database_Connection.rb"
require "./TestHangmanDisplay.rb"

def select_random_word
	records = Word.all
	index = Random.new.rand(records.length)
	records[index]
end

def blankout_selected_word(word_selected) 
	word_split_as_char_array = word_selected.spell.split(//)
	#word_split_as_char_array.each{|as_char| puts as_char}
	word_as_asterix = Array.new(word_split_as_char_array.length)
	word_as_asterix.length.times{|count| word_as_asterix[count] = '*'}
	#puts "#{word_as_asterix.join}"
	return word_split_as_char_array, word_as_asterix
end

def hangman_game
  system('cls')
	original_word_array, asterixed_word_array = blankout_selected_word(select_random_word())
	
	errored_attempt = 0
	while (original_word_array != asterixed_word_array and errored_attempt < 6)
    select_display_hangman(errored_attempt)
    puts "\n\n"
		puts " Asterixed word = #{asterixed_word_array.join}"
    puts "\n\n"
		puts "which letter would you like to enter:"
		guessed_letter = gets.chomp.downcase
		
		found_in_this_attempt = false
		index_in_array = 0

    if asterixed_word_array.include?(guessed_letter)
      puts "Letter already uncovered."
    else
      for index_in_array in 0...original_word_array.length
        if guessed_letter == original_word_array[index_in_array] or guessed_letter.upcase == original_word_array[index_in_array]
          found_in_this_attempt = true
          asterixed_word_array[index_in_array] = original_word_array[index_in_array]
        end
      end

      if !found_in_this_attempt
        puts "#{guessed_letter} not in the word"
        errored_attempt =  errored_attempt+1
      end
    end
   end

    if errored_attempt >= 6
      select_display_hangman(errored_attempt)
      puts "You Lost!!!"
    else
      puts "You Won!!!"
      puts " Original word = #{original_word_array.join}"
    end
	end 

hangman_game()