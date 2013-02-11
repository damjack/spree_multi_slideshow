class MultiSlideshowNamespace < ActiveRecord::Migration
  def change
    rename_table :slideshows, :spree_slideshows
    rename_table :slides, :spree_slides
  end
end
