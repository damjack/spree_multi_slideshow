module Spree
  module Admin
    class SlideSettingsController < Spree::Admin::BaseController
      def edit
        @styles = ActiveSupport::JSON.decode(Spree::Config[:attachment_styles])
      end

      def update
        update_styles(params)

        Spree::Config.set(params[:preferences])
        update_paperclip_settings

        respond_to do |format|
          format.html {
            flash[:success] = t(:slide_settings_updated)
            redirect_to edit_admin_image_settings_path
          }
        end
      end


      private

      def update_styles(params)
        params[:new_slide_styles].each do |index, style|
          params[:slide_styles][style[:name]] = style[:value] unless style[:value].empty?
        end if params[:new_slide_styles].present?

        styles = params[:slide_styles]

        Spree::Config[:slide_styles] = ActiveSupport::JSON.encode(styles) unless styles.nil?
      end

      def update_paperclip_settings

        Spree::Slide.attachment_definitions[:attachment][:styles] = ActiveSupport::JSON.decode(Spree::Config[:slide_styles])
        Spree::Slide.attachment_definitions[:attachment][:path] = Spree::Config[:slide_path]
        Spree::Slide.attachment_definitions[:attachment][:default_url] = Spree::Config[:slide_default_url]
        Spree::Slide.attachment_definitions[:attachment][:default_style] = Spree::Config[:slide_default_style]
      end
    end
  end
end

