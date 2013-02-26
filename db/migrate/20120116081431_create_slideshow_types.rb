class CreateSlideshowTypes < ActiveRecord::Migration
  def change
    create_table :slideshow_types do |t|
      t.string :category
      t.boolean :enabled, :default => false
      t.boolean :enable_navigation, :default => false
      
      t.timestamps
    end
    add_index :slideshow_types, :category, :unique => true
  end
end
