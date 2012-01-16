class CreateSlideshowTypes < ActiveRecord::Migration
  def change
    create_table :slideshow_types do |t|
      t.string :category
      t.boolean :enabled, :default => 0
      t.integer :width, :default => 500
      t.integer :slide_number, :default => 4
      t.boolean :enable_navigation, :default => 1
      
      t.timestamps
    end
  end
end
