require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		# uses test/fixtures "Michael" fixture
		@user = users(:michael)
	end
	# For INVALID info, test:
	
	# Visit the login path.
	# Verify that the new sessions form renders properly.
	# Post to the sessions path with an invalid params hash.
	# Verify that the new sessions form gets re-rendered and that a flash message appears.
	# Visit another page (such as the Home page).
	# Verify that the flash message doesn’t appear on the new page.
  test "login with invalid information" do
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, params: { session: { email: "", password: "" } }
  	assert_template 'sessions/new'
  	assert_not flash.empty?
  	get root_path
  	assert flash.empty?
  end

  test "login with valid email/invalid password" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:    @user.email,
                                          password: "invalid" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?                                      
    # check redirect target
    assert_redirected_to @user
    # actually visit targeted page
    follow_redirect!
    assert_template 'users/show'
    # should be zero login_path(s) when already logged in
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # Simulate a user clicking logout in a second window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies[:remember_token]
  end

  test "login without remembering" do
    # log in to set the cookie
    log_in_as(@user, remember_me: '1')
    # Log in again and verigy that the cookie is deleted
    log_in_as(@user, remember_me: '0')
    assert_empty cookies[:remember_token]
  end


end

