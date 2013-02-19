class AddUserIdIndexToComments < ActiveRecord::Migration
  def change
  	add_index :comments, :user_id, :name => "User_id Comments index"
  end
end
