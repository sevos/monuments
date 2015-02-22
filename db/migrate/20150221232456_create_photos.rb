class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :monument_id
      t.string :title
      t.string :description
      t.string :image
      t.datetime :taken_at

      t.timestamps null: false
    end
  end
end
