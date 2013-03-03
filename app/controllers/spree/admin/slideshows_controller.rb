module Spree
  module Admin
    class SlideshowsController < ResourceController
      
      def show
        redirect_to( :action => :edit )
      end
      
      def location_after_save
        edit_admin_slideshow_url(@slideshow)
      end

    end
  end 
end