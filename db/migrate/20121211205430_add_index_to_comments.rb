class AddIndexToComments < ActiveRecord::Migration
  def change
  	  add_index :comments, [:commentable_id, :commentable_type], :name => "Comments index"
  end
end