class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.string :url
      t.string :user_name

      t.timestamps null: false
    end
  end
end
