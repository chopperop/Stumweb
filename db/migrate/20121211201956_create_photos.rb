class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :image
      t.datetime :content_changed_at

      t.timestamps
    end
  end
end
