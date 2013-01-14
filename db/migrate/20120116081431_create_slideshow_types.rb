class CreateSlideshowTypes < ActiveRecord::Migration
  def change
    create_table :slideshow_types do |t|
      t.string :category
      t.boolean :enabled, :default => false
      t.integer :slide_height, :default => 400
      t.integer :slide_width, :default => 900
      t.integer :slide_number, :default => 4
      t.boolean :enable_navigation, :default => false
      
      t.timestamps
    end
    add_index :slideshow_types, :category, :unique => true
  end
end
