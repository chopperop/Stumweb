class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :team_name
      t.string :username
      t.integer :team_score

      t.timestamps
    end
  end
end
