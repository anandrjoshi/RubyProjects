require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
  
  test "create an user" do
    assert_difference('User.count') do
      user = User.new(:first_name => 'George', :last_name => 'Orwell')
      assert user.save
    end
  end
  
  test "create an user with no first name" do
    user = User.new(:first_name => '', :last_name => 'Orwell')
    assert !user.valid?
  end
  
  test "create an user with no last name" do
    user = User.new(:first_name => 'George', :last_name => '')
    assert !user.valid?
  end
  
  test "create an user with no first or last name" do
    user = User.new(:first_name => '', :last_name => '')
    assert !user.valid?
  end

  test "save fails with exception on violation" do
    user = User.new(:first_name => 'George', :last_name => '')
    assert_raise(ActiveRecord::RecordInvalid) { user.save! }
  end
  
  test "create an user that already exists" do
    user = User.new(:first_name => 'Rohit', :last_name => 'Nirmal')
    assert !user.valid?
  end

  test "search for a user that exists" do
    users =  User.search('Rohit', 'Nirmal')
	assert_equal users.length, 1
	assert users[0].valid?
  end

  test "search for a user that does not exists" do
    users =  User.search('##$$%%', '##$$%%')
	assert_equal users.length, 0
	#assert users[0].valid?
  end
  
  test "create an user with non-ascii first name and last name" do
    user = User.new(:first_name => '##@@$$', :last_name => '9898557')
    assert !user.valid?
  end
end
