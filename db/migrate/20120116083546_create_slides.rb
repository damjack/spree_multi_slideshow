class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :title, :url
      t.text :content
      
      t.string   :attachment_content_type, :attachment_file_name, :attachment_content_type
      t.datetime :attachment_updated_at
      t.integer  :attachment_size, :position
      t.string   :type, :limit => 75

      t.references :slideshow_type
      
      t.timestamps
    end
  end
end
