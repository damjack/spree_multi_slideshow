module Spree
  module Admin
    class SlidesController < ResourceController
      before_filter :load_data, :except => [:destroy]
      
      def update_positions
        params[:positions].each do |id, index|
          Spree::Slide.where(:id => id).update_all(:position => index)
        end

        respond_to do |format|
          format.js  { render :text => 'Ok' }
        end
      end

      protected
      def location_after_save
        admin_slideshow_type_slides_url(@slideshow_type)
      end
      
      def load_data
        @slideshow_type = Spree::SlideshowType.find(params[:slideshow_type_id])
      end
    end
  end
end
