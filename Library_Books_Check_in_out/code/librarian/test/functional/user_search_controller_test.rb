require 'test_helper'

class UserSearchControllerTest < ActionController::TestCase
  setup do
	@user = users(:one)
  end
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "should get user search" do
    get :search
    assert_response :success
  end
  
  test "exact search for a user" do
	get :search, :first_name => users(:one).first_name, :last_name => users(:one).last_name
	assert_equal assigns(:users).size, 1
	assert_equal assigns(:users)[0].first_name, users(:one).first_name
	assert_equal assigns(:users)[0].last_name, users(:one).last_name
  end
  
  test "partial search for a user" do
	get :search, :first_name => '', :last_name => ''
	assert_equal assigns(:users).size, 2
  end
  
  test "no match for bad user" do
	get :search, :first_name => 'abc', :last_name => 'def'
	assert_equal assigns(:users).size, 0
  end
  
end
