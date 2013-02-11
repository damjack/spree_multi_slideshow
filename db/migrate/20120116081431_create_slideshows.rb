class CreateSlideshows < ActiveRecord::Migration
  def change
    create_table :slideshows do |t|
      t.string :category
      t.boolean :enabled, :default => false
      t.boolean :enable_navigation, :default => true
      t.boolean :enable_pagination, :default => false
      
      t.timestamps
    end
    add_index :slideshows, :category, :unique => true
  end
end
