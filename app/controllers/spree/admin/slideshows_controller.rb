module Spree
  module Admin
    class SlideshowsController < ResourceController

      def location_after_save
        edit_admin_slideshow_url(@slideshow)
      end

    end
  end 
end