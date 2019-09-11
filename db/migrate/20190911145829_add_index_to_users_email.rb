class AddIndexToUsersEmail < ActiveRecord::Migration[6.0]
	# add index to ensure email entries are unique on the database level to avoid immediate
	# duplication by a user fast-submitting records
  def change
  	add_index :users, :email, unique: true
  end
end
