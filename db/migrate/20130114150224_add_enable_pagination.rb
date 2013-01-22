class AddEnablePagination < ActiveRecord::Migration
  def change
    add_column :spree_slideshow_types, :enable_pagination, :boolean, :default => false, :after => :enable_navigation
  end
end
