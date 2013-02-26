Deface::Override.new(:virtual_path => "spree/layouts/admin",
                      :name => "slideshow_type_admin_tab",
                      :insert_bottom => "[data-hook='admin_tabs']",
                      :text => "<%= tab(:slideshow_types) %>")

Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                     :name => "add_slide_setting_to_configuration_menu",
                     :insert_bottom => "[data-hook='admin_configurations_menu']",
                     :partial => "spree/admin/shared/slide_setting_configurations_menu")