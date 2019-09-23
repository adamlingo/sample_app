require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	before { @user = User.new(name: "Adam", email: "adam@gmail.com", password: "password", id: 1) }
	
	context 'GET #show' do
		it 'routes /users/1 to user_path' do
			expect(get: user_path(@user.id)).to route_to(controller: "users", action: "show", id: "1")
			
		end
	end

	context 'GET #new' do
		it 'routes /users/new to signup_path' do
			expect(get: signup_path).to route_to(controller: "users", action: "new")
		end
	end

	context 'POST #create' do
		it 'routes /users to users#create' do
			expect(post: "/users").to route_to(:controller => "users", :action => "create")
		end
	end

	context 'GET #edit' do
		it 'routes /users/1/edit to edit_user_path' do
			expect(get: "/users/1/edit").to route_to(:controller => "users", :action => "edit", id: "1")
		end
	end

	context 'PUT #update' do
		it 'routes /users/1 to users#update' do
			expect(put: "/users/1").to route_to(:controller => "users", :action => "update", id: "1")
		end
	end
end
