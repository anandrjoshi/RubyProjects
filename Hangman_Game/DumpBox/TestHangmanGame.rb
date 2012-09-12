require 'test/unit'
require 'sqlite3'
require 'active_record'
require "./Word_Class.rb"
require "./Word_Select_Display.rb"

class TestHangmanGame < Test::Unit::TestCase
	def setup
		@@original_word_array, @@display_word_array = blankout_selected_word(select_random_word())
	end
	
	def test_display_word_creation_size
		assert @@original_word_array.size==@@display_word_array.size
	end
	
	def test_display_word_all_asterisk
		@@display_word_array.each do |c|
			assert c=='*'
		end
	end
	
end  