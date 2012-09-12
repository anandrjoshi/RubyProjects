require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = User.new(:first_name => 'Totally', :last_name => 'New')
	@user2 = users(:one)
	@book = books(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => @user.attributes
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, :id => @user2.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user2.to_param
    assert_response :success
  end

  test "should update user" do
    put :update, :id => @user2.to_param, :user => @user2.attributes
    assert_redirected_to user_path(assigns(:user))
  end

  test "should fail to update user with invalid params" do
    put :update, :id => @user2.to_param, :user => {:first_name => '', :last_name => 'Nirmal'}
    assert_response :success
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user2.to_param
    end
    assert_redirected_to users_path
  end

  test "fail to destroy user with book checked out" do
	@book.users << @user    
	 assert_no_difference('User.count') do
      delete :destroy, :id => @user.to_param
    end
  end

  test "shouldn't create a user with no name" do
      assert_no_difference('User.count') do
      post :create, :user => {:first_name => '', :last_name => ''}
      assert_response :success
      assert_template :new
      assert_not_nil assigns(:user)
      assert assigns(:user).errors.full_messages[0].include? "can't be blank"
    end
  end
end
