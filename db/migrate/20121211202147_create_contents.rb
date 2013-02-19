class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.integer :user_id
      t.text :content
      t.datetime :content_changed_at

      t.timestamps
    end
  end
end
