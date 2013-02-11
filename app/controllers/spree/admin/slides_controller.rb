module Spree
  module Admin
    class SlidesController < ResourceController
      before_filter :load_data
      
      create.before :set_slideshow
      update.before :set_slideshow
      destroy.before :destroy_before
      
      def update_positions
        params[:positions].each do |id, index|
          Spree::Slide.update_all(['position=?', index], ['id=?', id])
        end

        respond_to do |format|
          format.html { redirect_to admin_slideshow_slides_url(@slideshow) }
          format.js  { render :text => 'Ok' }
        end
      end

      private
      def location_after_save
        admin_slideshow_images_url(@slideshow)
      end
      
      def load_data
        @slideshow = Spree::Slideshow.find(params[:slideshow_id].to_i)
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
