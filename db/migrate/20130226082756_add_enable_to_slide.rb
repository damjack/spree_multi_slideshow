class AddEnableToSlide < ActiveRecord::Migration
  def change
    add_column :spree_slides, :enable, :boolean, :default => true, :after => :content
    remove_column :spree_slideshow_types, :slide_number
    remove_column :spree_slideshow_types, :slide_width
    remove_column :spree_slideshow_types, :slide_height
  end
end
