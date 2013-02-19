class AddCacheColumnsToContents < ActiveRecord::Migration
  def self.up
    add_column :contents, :cached_votes_total, :integer, :default => 0
    add_column :contents, :cached_votes_up, :integer, :default => 0
    add_column :contents, :cached_votes_down, :integer, :default => 0
    add_index  :contents, :cached_votes_total
    add_index  :contents, :cached_votes_up
    add_index  :contents, :cached_votes_down
  end

  def self.down
    remove_column :contents, :cached_votes_total
    remove_column :contents, :cached_votes_up
    remove_column :contents, :cached_votes_down
  end
end
