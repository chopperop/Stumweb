class CreateCaptions < ActiveRecord::Migration
  def change
    create_table :captions do |t|
      t.text :body
      t.integer :photo_id

      t.timestamps
    end
  end
end
