class CreateSlides < ActiveRecord::Migration
  def change
    create_table :slides do |t|
      t.string :title, :url
      
      t.string   :image_content_type, :image_file_name
      t.integer  :image_size, :position
      t.integer  :image_width, :image_height

      t.references :slideable, :polymorphic => true
      
      t.timestamps
    end
  end
end
