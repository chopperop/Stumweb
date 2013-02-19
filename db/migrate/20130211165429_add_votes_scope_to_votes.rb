class AddVotesScopeToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :vote_scope, :string
  end
end
