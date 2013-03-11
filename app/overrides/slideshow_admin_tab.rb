Deface::Override.new(:virtual_path => "spree/layouts/admin",
                      :name => "slideshow_admin_tab",
                      :insert_bottom => "[data-hook='admin_tabs']",
                      :text => "<%= tab(:slideshows, :icon => 'icon-picture') %>")

Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                      :name => "add_slide_settings",
                      :insert_bottom => "[data-hook='admin_configurations_sidebar_menu'], #admin_configurations_sidebar_menu[data-hook]",
                      :text => "<%= configurations_sidebar_menu_item t(:slide_settings), edit_admin_slide_settings_path %>")
                      