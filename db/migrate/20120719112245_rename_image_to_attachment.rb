class RenameImageToAttachment < ActiveRecord::Migration
  def up
    rename_column :slides, :image_content_type, :attachment_content_type
    rename_column :slides, :image_file_name, :attachment_file_name
    rename_column :slides, :image_updated_at, :attachment_updated_at
    rename_column :slides, :image_size, :attachment_size
  end
  
  def down
    rename_column :slides, :attachment_content_type, :image_content_type
    rename_column :slides, :attachment_file_name, :image_file_name
    rename_column :slides, :attachment_updated_at, :image_updated_at
    rename_column :slides, :attachment_size, :image_size
  end
end