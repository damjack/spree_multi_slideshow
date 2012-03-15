module Spree
  module Admin
    class SlideshowTypesController < BaseController

      def location_after_save
        edit_admin_slideshow_type_url(@slideshow_type)
      end

    end
  end 
end