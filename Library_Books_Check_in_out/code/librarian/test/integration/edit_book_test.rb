require 'test_helper'

class EditBookTest < ActionController::IntegrationTest
  fixtures :books

  test "edit a book title" do
    book1 = books(:one)
    get "/books/#{book1.id}/edit"    
    
    assert_response :success
    
    put_via_redirect "/books/#{book1.id}", :book => { :id => books(:one).id, :title => 'The Decline', :edition => 2011, :publisher => 'Vault Dweller', :authors => 'Andhaira'}
    assert_response :success
    
    assert_equal 'Book was successfully updated.', flash[:notice]
  end
  
  test "search for book" do
    get "/book_search/search"    
    assert_response :success
    
    get "/book_search/search", :title => books(:one).title
    assert_response :success
	
	assert_equal assigns(:books).size, 1
	assert_equal assigns(:books)[0].title, books(:one).title
  end
  
  test "search for book not found" do
    get "/book_search/search"    
    assert_response :success
    
    get "/book_search/search", :title => 'Not Here'
    assert_response :success
	
	assert_equal assigns(:books).size, 0
  end
  
  test "add a book" do
    book1 = Book.new(:title => 'New Book', :edition => 2, :publisher => 'The Pub', :authors => 'Hey There')
    get "books/new"    
    
    assert_response :success
    
    post_via_redirect "/books/#{book1.id}", :book => book1.attributes
    assert_response :success
    
    assert_equal 'Book was successfully created.', flash[:notice]
  end
	
   test "check out book successfully" do
    get "/book_check_out/#{books(:one).id}" 
	assert_response :success
	
	put "/book_check_out/#{books(:one).id}/check_out", :id => books(:one).to_param, :first_name => users(:one).first_name, :last_name => users(:one).last_name
    assert_response :success
	assert_equal assigns(:book).users.size, 1
	assert_equal assigns(:book).users[0].first_name, users(:one).first_name
	assert_equal assigns(:book).users[0].last_name, users(:one).last_name
  end
  
  test "check out book to nonexistent user" do
    get "/book_check_out/#{books(:one).id}" 
	assert_response :success
	
	put "/book_check_out/#{books(:one).id}/check_out", :id => books(:one).to_param, :first_name => 'blah', :last_name => 'blah'
    assert_response :redirect
  end
  
  test "check in book" do
	books(:one).users << users(:one)  
    get "/book_check_in/#{books(:one).id}" 
	assert_response :success
	
	put "/book_check_in/#{books(:one).id}/check_in"
    assert_response :success
	assert_equal assigns(:book).users.size, 0
  end
end
