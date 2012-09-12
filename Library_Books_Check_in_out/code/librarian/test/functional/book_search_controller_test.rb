require 'test_helper'

class BookSearchControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "should get search" do
    get :search
    assert_response :success
  end
  
  test "exact search for a book" do
	get :search, :title => '1984'
	assert_equal assigns(:books).size, 1
	assert_equal assigns(:books)[0].title, '1984'
	assert_equal assigns(:books)[0].authors, 'George Orwell'
  end
  
  test "partial search for a book" do
	get :search, :title => ''
	assert_equal assigns(:books).size, 2
  end
  
  test "no match for bad book" do
	get :search, :title => 'nonexistant'
	assert_equal assigns(:books).size, 0
  end
  
  
end
