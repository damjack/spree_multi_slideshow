class AddEnablePagination < ActiveRecord::Migration
  def change
    add_column :enable_pagination, :boolean, :default => false, :after => :enable_navigation
  end
end
