require 'rails_helper'

RSpec.describe User, type: :model do
	# global @user for user tests
	before { @user = User.new(name: "Adam", email: "adam@gmail.com", password: "password")}

  context 'validation tests' do
  	# valid basic model creation (equivalent of should save)
  	it 'user should be valid' do
  		expect(@user).to be_valid
  	end
  	
  	it 'ensures name presence' do
  		user = User.new(name: "  ").save
  		expect(user).to eq(false)
  	end

  	it 'ensures email presence' do
  		user = User.new(email: "  ").save
  		expect(user).to eq(false)
  	end

  	it 'ensures name is not too long' do
  		@user.name = "a" * 51
  		expect(@user).to_not be_valid
  	end

  	it 'ensures email is not too long' do
  		@user.email = "a" * 244
  		expect(@user).to_not be_valid
  	end
  	
  	it 'ensures email accepts valid regex format' do
	  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]

	    valid_addresses.each do |valid_address|
	      @user.email = valid_address
	      # inspect each element to point to any specific failures
	      expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
	    end
	  end
	  # email is not regex build <--- needs rspec conversion

	  it 'ensures email rejects invalid regex format' do
	  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    	invalid_addresses.each do |invalid_address|
	      @user.email = invalid_address
	      expect(@user).to_not be_valid, "#{invalid_address.inspect} should be invalid"
	    end
	  end

	  it 'ensures emails are unique' do
	  	dup_user = @user.dup
	  	@user.save
	  	expect(dup_user).to_not be_valid
	  end

	  it 'ensures email addresses are saved as lower-case' do
	  	mixed_case_email = "Foo@ExAmPlE.coM"
	  	@user.email = mixed_case_email
	  	@user.save
	  	expect(mixed_case_email.downcase).to eq(@user.reload.email)
	  end

	  it 'ensures password is not blank' do
	  	@user.password = @user.password_confirmation = " "  * 6
	  	# invalid password will make entire @user record invalid
	  	expect(@user).to_not be_valid
	  end

	  it 'ensures password has minimum length' do
	  	@user.password = @user.password_confirmation = "a" * 5
	  	# invalid (too short) password makes @user not valid
	  	expect(@user).to_not be_valid
	  end

	  it 'asserts authenticated? should return false for a user with nil digest' do
	  	expect(@user.authenticated?('')).to_not eq(true)
	  end

	  ## more later, currently all pass
  	
  end

  context 'scope tests' do
  	# find more scope tests worth writing, even though the creator of RSpec finds them
  	# unnecessary if your behavioral tests pass.
  end
end
