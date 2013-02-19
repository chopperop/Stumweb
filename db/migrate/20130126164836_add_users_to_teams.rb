class AddUsersToTeams < ActiveRecord::Migration
  def change
  	add_column :teams, :user1, :string
  	add_column :teams, :user_id1, :integer
  	add_column :teams, :user2, :string
  	add_column :teams, :user_id2, :integer
  	add_column :teams, :user3, :string
  	add_column :teams, :user_id3, :integer
  	add_column :users, :team_id, :integer
  end
end
