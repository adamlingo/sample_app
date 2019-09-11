require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # @user available in all tests, use 'setup' which auto-runs before each test
  def setup
  	@user = User.new(name: "Example User", email: "user@example.com")
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "   "
  	assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "   "
    assert_not @user.valid?
  end
  # .length tests of name and email
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
end
