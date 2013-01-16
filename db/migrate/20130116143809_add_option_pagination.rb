class AddOptionPagination < ActiveRecord::Migration
  def up
    add_column :slideshow_types, :enable_pagination, :boolean, :default => false, :after => :enable_navigation
    add_column :slides, :attachment_width, :string, :after => :attachment_size
    add_column :slides, :attachment_height, :string, :after => :attachment_width
  end
  
  def down
    remove_column :slideshow_types, :enable_pagination
    remove_column :slides, :attachment_width
    remove_column :slides, :attachment_height
  end
end
