class Admin::SlideshowTypesController < Admin::ResourceController
  
  def location_after_save
      edit_admin_slideshow_type_url(@slideshow_type)
    end
      
end