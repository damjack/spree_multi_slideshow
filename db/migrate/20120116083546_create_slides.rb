class CreateSlides < ActiveRecord::Migration
  def change
    create_table :spree_slides do |t|
      t.string :title, :url
      
      t.string   :image_content_type, :image_file_name, :image_content_type
      t.datetime :image_updated_at
      t.integer  :image_size, :position
      t.string   :type, :limit => 75

      t.references :spree_slideshow_type
      
      t.timestamps
    end
  end
end
