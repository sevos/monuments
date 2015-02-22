class AddPublishedAndApprovedToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :published, :boolean
    add_column :photos, :approved, :boolean
  end
end
