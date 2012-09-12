require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  setup do
    @book = books(:one)
	@user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:books)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create book" do
    assert_difference('Book.count') do
      post :create, :book => @book.attributes
    end

    assert_redirected_to book_path(assigns(:book))
  end

  test "should show book" do
    get :show, :id => @book.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @book.to_param
    assert_response :success
  end

  test "should update book" do
    put :update, :id => @book.to_param, :book => @book.attributes
    assert_redirected_to book_path(assigns(:book))
  end

  test "should fail to update book with invalid params" do
    put :update, :id => @book.to_param, :book => {:title => '', :edition => 2011, :publisher => 'A pub', :authors => "Rohit"}
    assert_response :success
  end

  test "should destroy book" do
    assert_difference('Book.count', -1) do
      delete :destroy, :id => @book.to_param
    end
    assert_redirected_to books_path
  end

  test "fail to destroy book checked out" do
	@book.users << @user    
	 assert_no_difference('Book.count') do
      delete :destroy, :id => @book.to_param
    end
  end
  
  test "shouldn't create a book with no name" do
    assert_no_difference('Book.count') do
      post :create, :book => {:title => '', :edition => 2011, :publisher => 'A pub', :authors => "Rohit"}
      assert_response :success
      assert_template :new
      assert_not_nil assigns(:book)
      assert @response.body.include? '1 error prohibited this book from being saved:'
      assert @response.body.include? "Title can't be blank"
      # or!
      assert assigns(:book).errors.full_messages[0].include? "can't be blank"
    end
  end
  
end
