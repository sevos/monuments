class CreateMonuments < ActiveRecord::Migration
  def change
    create_table :monuments do |t|
      t.string :name
      t.text :description
      t.integer :collection_id
      t.string :state, default: 'new'

      t.timestamps null: false
    end
  end
end
