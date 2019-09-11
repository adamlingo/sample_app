require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
	# this test is designed to ensure that an invalid new User record won't increase the User count
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    # check that failed submission re-renders new
    assert_template 'users/new'
  end
end
