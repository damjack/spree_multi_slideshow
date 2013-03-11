module Spree
  module Admin
    class SlideshowsController < ResourceController
      def index
        respond_with(@collection)
      end
      
      def show
        redirect_to( :action => :edit )
      end
      
      protected
      def find_resource
        Spree::Slideshow.find(params[:id])
      end
      
      def location_after_save
         edit_admin_slideshow_url(@slideshow)
      end
      
      def collection
        return @collection if @collection.present?
        params[:q] ||= {}
        params[:q][:s] ||= "category asc"
        
        @search = super.ransack(params[:q])
        @collection = @search.result
      end
    end
  end 
end