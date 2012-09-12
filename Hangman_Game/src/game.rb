require "./src/hangman.rb"
require "./src/displayhangman.rb"

def select_random_word(filename)
  if File.exist?(filename)
    word_pool_array = Array.new
    File.open(filename, "r").each_line do |line|
      word_pool_array << line.chomp
    end
    index = Random.new.rand(word_pool_array.length)
    return word_pool_array[index]
  else
    return -1
  end
end

do_you_want_to_continue = "Y"
while do_you_want_to_continue == "Y"
	word_selected = select_random_word("./src/word_list.txt")
	if word_selected == -1
	  puts "Incorrect file name"
	else
	  game = Hangman.new(word_selected)
	  system('cls')
	  while !game.game_over
		select_display_hangman(game.errored_attempt)
		puts "\n\nGuess this word: #{game.word_as_asterix}"
		puts "\n\nWhich letter would you like to enter:"
		guessed_letter = gets.chomp.downcase
		system('cls')
		
		if game.validate_guessed_letter(guessed_letter)
		  puts "\n\n#{game.guess_letter(guessed_letter)[0]}"
		else
		  puts "\n\n\"#{guessed_letter}\" is not valid."
		end
	  end
	  
	  select_display_hangman(game.errored_attempt)
	  if  game.errored_attempt < 6
		puts "\n\n\"#{word_selected}\" guessed successfully. You Won!!!"
	  else
		puts "\n\nAttempt to guess \"#{word_selected}\" was unsuccessful. You Lost!!!"
	  end
	  puts "\n\nPlay again? Y/N"
	  do_you_want_to_continue = gets.chomp.upcase	
	end	
end