class CreateSlideshowTypes < ActiveRecord::Migration
  def change
    create_table :spree_slideshow_types do |t|
      t.string :category
      t.boolean :enabled, :default => 0
      t.integer :slide_height, :default => 400
      t.integer :slide_width, :default => 900
      t.integer :slide_number, :default => 4
      t.boolean :enable_navigation, :default => 1
      
      t.timestamps
    end
  end
end
