require 'test/unit'
require './Add_Words_Script'

class TestWordAddition < Test::Unit::TestCase
  def test_addition_of_valid_word
	get_count_before = Word.all.count
	word = Word.new(:spell => 'Repetition')
	word.save
	assert word.valid?
	assert_equal('Repetition', word.spell)
	get_count_after = Word.all.count
	assert_equal(1, get_count_after - get_count_before)
	word.delete
  end
  
  def test_addition_of_word_of_length_less_than_seven
    word = Word.new(:spell => 'apple')
	assert !word.valid?
  end
  
  def test_addition_of_word_of_length_equal_to_seven
    word = Word.new(:spell => 'problem')
	assert word.valid?
	assert_equal('problem', word.spell)
  end
  
  def test_addition_of_blank_word
    word = Word.new(:spell => '')
	assert !word.valid?
  end
  
  def test_addition_of_word_with_special_characters
    word = Word.new(:spell => '@@@123ABC')
	assert !word.valid?
  end
  
  def test_addition_of_same_word_again
    word = Word.new(:spell => 'Computer')
	assert !word.valid?
  end
	
  def reset_db
    db_file_name = 'assign_1.db'
    schema_file_name = 'create_words_collection.sql'
    File.delete db_file_name
    `sqlite3 #{db_file_name} < #{schema_file_name}`
  end	
end  