class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :title, :url
      
      t.string   :image_content_type, :image_file_name
      t.datetime :image_updated_at
      t.integer  :image_size, :position
      t.string   :type, :limit => 75

      t.references :slideshow_type
      
      t.timestamps
    end
  end
end
