require 'test_helper'

class BookCheckInControllerTest < ActionController::TestCase
setup do
    @book = books(:one)
  end  

test "Check in book successfully" do
	books(:one).users << users(:one)    
	put :check_in, :id => books(:one).id
    assert_response :success
	assert_equal assigns(:book).users.size, 0
  end
end
