class CounterCacheToContentsAndPhotos < ActiveRecord::Migration
  def up
  	add_column :contents, :impressions_count, :integer, :default => 0
  	add_column :photos, :impressions_count, :integer, :default => 0
  	add_index :contents, :impressions_count, :name => "contents_impressions_count"
  	add_index :photos, :impressions_count, :name => "photos_impressions_count"
  end

  def down
  	remove_column :contents, :impressions_count, :integer, :default => 0
  	remove_column :photos, :impressions_count, :integer, :default => 0
  	remove_index :contents, :impressions_count, :name => "contents_impressions_count"
  	remove_index :photos, :impressions_count, :name => "photos_impressions_count"
  end
end
