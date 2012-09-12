require 'test_helper'

class BookCheckOutControllerTest < ActionController::TestCase
setup do
    @book = books(:one)
  end  

test "should get show" do
    get :show, :id => @book.to_param
    assert_response :success
  end

test "Check out book successfully" do
    put :check_out, :id => @book.to_param, :first_name => users(:one).first_name, :last_name => users(:one).last_name
    assert_response :success
	assert_equal assigns(:book).users.size, 1
	assert_equal assigns(:book).users[0].first_name, users(:one).first_name
	assert_equal assigns(:book).users[0].last_name, users(:one).last_name
  end

test "Check out book to nonexisting user" do
    put :check_out, :id => @book.to_param, :first_name => 'No', :last_name => 'Body'
    assert_response :redirect
  end
end
