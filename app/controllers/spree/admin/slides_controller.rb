module Spree
  module Admin
    class SlidesController < ResourceController
      before_filter :load_data
      
      create.before :set_slideshow
      update.before :set_slideshow
      destroy.before :destroy_before

      private
      def location_after_save
        admin_slideshow_slides_url(@slideshow)
      end
      
      def load_data
        @slideshow = Spree::Slideshow.find(params[:slideshow_id])
      end
      
      def set_slideshow
        @slide.slideshow_id = params[:slide][:slideshow_id]
      end
      
      def destroy_before
        @viewable = @slide.slideshow
      end

    end
  end
end
