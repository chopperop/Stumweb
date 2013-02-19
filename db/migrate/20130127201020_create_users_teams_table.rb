class CreateUsersTeamsTable < ActiveRecord::Migration
  def up
  	create_table :teams_users, :id => false do |t|
      t.integer :team_id
      t.integer :user_id
    end
  end

  def down
  	drop_table :teams_users
  end
end
