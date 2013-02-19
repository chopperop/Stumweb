class ChangeTeamScoreToDefaultZeroToTeams < ActiveRecord::Migration
  def up
  	change_column :teams, :team_score, :integer, :default => 0
  end

  def down
  	change_column :teams, :team_score, :integer
  end
end
