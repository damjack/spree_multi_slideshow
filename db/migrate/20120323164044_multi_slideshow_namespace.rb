class MultiSlideshowNamespace < ActiveRecord::Migration
  def change
    rename_table :slideshow_types, :spree_slideshow_types
    rename_table :slides, :spree_slides
  end
end
