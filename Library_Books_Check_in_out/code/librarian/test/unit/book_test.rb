require 'test_helper'

class BookTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "create a book" do
    assert_difference('Book.count') do
      book = Book.new(:title => 'The Book', :edition => 1, :publisher => 'Pub', :authors => 'Anand Joshi')
      assert book.save
    end
  end
  
  test "create a book with no title" do
    book = Book.new(:title => '', :edition => 1, :publisher => 'Pub', :authors => 'Anand Joshi')
    assert !book.valid?
  end
    
  test "create a book with no edition" do
    book = Book.new(:title => 'The Book', :edition => '', :publisher => 'Pub', :authors => 'Anand Joshi')
    assert !book.valid?
  end

  
  test "create a book with no publisher" do
    book = Book.new(:title => 'The Book', :edition => 1, :publisher => '', :authors => 'Anand Joshi')
    assert !book.valid?
  end
  
  test "create a book with no author" do
    book = Book.new(:title => 'The Book', :edition => 1, :publisher => 'Pub', :authors => '')
    assert !book.valid?
  end
  
  test "create a book with no non numeric edition1" do
    book = Book.new(:title => 'The Book', :edition => '-1', :publisher => 'Pub', :authors => 'Anand Joshi')
    assert !book.valid?
  end
 
  test "create a book with no non numeric edition2" do
    book = Book.new(:title => 'The Book', :edition => 'asd', :publisher => 'Pub', :authors => 'Anand Joshi')
    assert !book.valid?
  end
   
  test "save fails with exception on violation" do
    book = Book.new(:title => '', :edition => 1, :publisher => 'Pub', :authors => 'Anand Joshi')
    assert_raise(ActiveRecord::RecordInvalid) { book.save! }
  end

  test "search for a book that exists" do
    books =  Book.search('The Codex')
	assert_equal books.length, 1
	assert books[0].valid?
  end 
end
