require 'test_helper'

class EditUserTest < ActionController::IntegrationTest
  fixtures :users

  test "edit a user name" do
    user1 = users(:one)
    get "/users/#{user1.id}/edit"    
    
    assert_response :success
    
    put_via_redirect "/users/#{user1.id}", :user => { :id => users(:one).id, :first_name => 'Paul', :last_name => 'Denton'}
    assert_response :success
	 
    assert_equal 'User was successfully updated.', flash[:notice]
  end
  
  test "search for user" do
    get "/user_search/search"    
    assert_response :success
    
    get "/user_search/search", :first_name => users(:one).first_name, :last_name => users(:one).last_name
    assert_response :success
	
	assert_equal assigns(:users).size, 1
	assert_equal assigns(:users)[0].first_name,users(:one).first_name
	assert_equal assigns(:users)[0].last_name,users(:one).last_name
  end
  
  test "search for user not found" do
    get "/user_search/search"    
    assert_response :success
    
    get "/user_search/search", :first_name => 'Not', :last_name => 'Here'
    assert_response :success
	
	assert_equal assigns(:users).size, 0
  end
  
  test "add a user" do
    user1 = User.new(:first_name => 'New', :last_name => 'Guy')
    get "users/new"    
    
    assert_response :success
    
    post_via_redirect "/users/#{user1.id}", :user => user1.attributes
    assert_response :success
    
    assert_equal 'User was successfully created.', flash[:notice]
  end
end
