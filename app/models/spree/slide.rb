module Spree
  class Slide < ActiveRecord::Base
    belongs_to :slideshow_type
    validate :no_attachment_errors
    
    attr_accessor :attachment_width, :attachment_height
    attr_accessible :title, :url, :attachment_width, :attachment_height, :content, :slideshow_type_id, :attachment, :enable
    
    has_attached_file :attachment,
            :url  => "/spree/slides/:id/:style_:basename.:extension",
            :path => ":rails_root/public/spree/slides/:id/:style_:basename.:extension",
            :styles => lambda {|a|
              {
                  :mini => "100x33#",
                  :small =>  "300x100#",
                  :medium => "600x200#",
                  :large =>  "900x300#",
                  :custom => "#{a.instance.attachment_width}x#{a.instance.attachment_height}#"
              }
            },
            :convert_options => {
                  :mini => "-gravity center",
                  :small => "-gravity center",
                  :medium => "-gravity center",
                  :large => "-gravity center",
                  :custom => "-gravity center"
            } 
    
    validates_presence_of :slideshow_type_id
    validates_attachment_presence :attachment
    validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/x-png', 'image/pjpeg'], :message => "deve essere JPG, JPEG, PNG o GIF"
    
    default_scope order("position ASC")
    scope :enable, {:conditions => {:enable => true}}
    after_post_process :find_dimensions
    
    # Load user defined paperclip settings
    if Spree::Config[:use_s3]
      s3_creds = { :access_key_id => Spree::Config[:s3_access_key], :secret_access_key => Spree::Config[:s3_secret], :bucket => Spree::Config[:s3_bucket] }
      Spree::Slide.attachment_definitions[:attachment][:storage] = :s3
      Spree::Slide.attachment_definitions[:attachment][:s3_credentials] = s3_creds
      Spree::Slide.attachment_definitions[:attachment][:s3_headers] = ActiveSupport::JSON.decode(Spree::Config[:s3_headers])
      Spree::Slide.attachment_definitions[:attachment][:bucket] = Spree::Config[:s3_bucket]
      Spree::Slide.attachment_definitions[:attachment][:s3_protocol] = Spree::Config[:s3_protocol] unless Spree::Config[:s3_protocol].blank?
      Spree::Slide.attachment_definitions[:attachment][:s3_host_alias] = Spree::Config[:s3_host_alias] unless Spree::Config[:s3_host_alias].blank?
    end

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
      if self.attachment_width.blank? && self.attachment_height.blank?
        temporary = attachment.queued_for_write[:original]
        filename = temporary.path unless temporary.nil?
        filename = attachment.path if filename.blank?
        geometry = Paperclip::Geometry.from_file(filename)
        self.attachment_width  = geometry.width
        self.attachment_height = geometry.height
      end
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
