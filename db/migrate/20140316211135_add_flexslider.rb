class AddFlexslider < ActiveRecord::Migration
  def change
    add_column :spree_slideshows, :is_bxslider, :boolean, :default => true
    add_column :spree_slideshows, :is_flexslider, :boolean, :default => false
    add_column :spree_slideshows, :touch, :boolean, :default => false
    add_column :spree_slideshows, :selector, :string
    add_column :spree_slideshows, :smooth_height, :boolean, :default => false
    add_column :spree_slideshows, :animation_speed, :integer
    add_column :spree_slideshows, :use_css, :boolean, :default => false
  end
end
