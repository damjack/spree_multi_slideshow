module Spree
  class Slide < ActiveRecord::Base
    belongs_to :slideshow
    
    belongs_to :slideable, :polymorphic => true
    
    validate :no_attachment_errors
    validates_presence_of :slideshow_id
    validates_attachment_presence :attachment
    validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/x-png', 'image/pjpeg'], :message => "deve essere JPG, JPEG, PNG o GIF"
    
    attr_accessor :attachment_width, :attachment_height
    attr_accessible :title, :url, :attachment_width, :attachment_height, :presentation, :slideshow_id, :attachment
    
    has_attached_file :attachment,
            :url  => "/spree/slides/:id/:style_:basename.:extension",
            :path => ":rails_root/public/spree/slides/:id/:style_:basename.:extension",
            :styles => ->(a) {{
                  :mini => "60x60#",
                  :small =>  "300x100#",
                  :medium => "600x200#",
                  :large =>  "900x300#",
                  :custom => "#{a.instance.attachment_width}x#{a.instance.attachment_height}#"
            }},
            :convert_options => { :all => '-strip -auto-orient' }
    # save the w,h of the original image (from which others can be calculated)
    # we need to look at the write-queue for images which have not been saved yet
    after_post_process :find_dimensions
    scope :enable, {:conditions => {:enabled => true}}

    include Spree::Core::S3Support
    supports_s3 :attachment

    Spree::Slide.attachment_definitions[:attachment][:styles] = ActiveSupport::JSON.decode(Spree::Config[:slide_styles])
    Spree::Slide.attachment_definitions[:attachment][:path] = Spree::Config[:slide_path]
    Spree::Slide.attachment_definitions[:attachment][:url] = Spree::Config[:slide_url]
    Spree::Slide.attachment_definitions[:attachment][:default_url] = Spree::Config[:slide_default_url]
    Spree::Slide.attachment_definitions[:attachment][:default_style] = Spree::Config[:slide_default_style]
    
    def initialize(*args)
      super(*args)
      last_slide = Spree::Slide.last
      self.position = last_slide ? last_slide.position + 1 : 0
    end
    
    def find_dimensions
      temporary = attachment.queued_for_write[:original]
      filename = temporary.path unless temporary.nil?
      filename = attachment.path if filename.blank?
      geometry = Paperclip::Geometry.from_file(filename)
      self.attachment_width = geometry.width
      self.attachment_height = geometry.height
    end

    # if there are errors from the plugin, then add a more meaningful message
    def no_attachment_errors
      unless attachment.errors.empty?
        # uncomment this to get rid of the less-than-useful interrim messages
        # errors.clear
        errors.add :attachment, "Paperclip returned errors for file '#{attachment_file_name}' - check ImageMagick installation or image source file."
        false
      end
    end
  end
end
