module Spree
  class Slide < ActiveRecord::Base
  
    has_many :slideshow_types
    validates_presence_of :slideshow_type_id
  
    has_attached_file :image,
            :url  => "/spree/slides/:id/:style_:basename.:extension",
            :path => ":rails_root/public/spree/slides/:id/:style_:basename.:extension",
            #:default_url => "/missing/:style.jpg",
            :styles => {
                  :thumbnail => "100x33#",
                  :small => "300x100#",
                  :medium => "600x200#",
                  :slide => "900x300#",
                  :custom => Proc.new { |instance| "#{SlideshowType.find(instance.slideshow_type_id).slide_width}x#{SlideshowType.find(instance.slideshow_type_id).slide_height}#" }
            },
            :convert_options => {
                  :thumbnail => "-gravity center",
                  :small => "-gravity center",
                  :medium => "-gravity center",
                  :slide => "-gravity center",
                  :custom => "-gravity center"
            } 
    
    after_post_process :find_dimensions
    #process_in_background :image UTILE MA OCCORRE ATTIVARE ANCHE LA GEMMA DELAYED-PAPERCLIP
    
    # Load S3 settings
    if (Rails.root.join('config', 's3.yml'))
      S3_OPTIONS = {
              :storage => 's3',
              :s3_credentials => Rails.root.join('config', 's3.yml')
            }
    elsif (ENV['S3_KEY'] && ENV['S3_SECRET'] && ENV['S3_BUCKET'])
      S3_OPTIONS = {
              :storage => 's3',
              :s3_credentials => {
                :access_key_id     => ENV['S3_KEY'],
                :secret_access_key => ENV['S3_SECRET']
              },
              :bucket => ENV['S3_BUCKET']
            }
    else
      S3_OPTIONS = { :storage => 'filesystem' }
    end
    
    attachment_definitions[:image] = (attachment_definitions[:image] || {}).merge(S3_OPTIONS)
    
    def initialize(*args)
      super(*args)
      last_slide = Slide.last
      self.position = last_slide ? last_slide.position + 1 : 0
    end
    
    def find_dimensions
      temporary = image.queued_for_write[:original]
      filename = temporary.path unless temporary.nil?
      filename = image.path if filename.blank?
      geometry = Paperclip::Geometry.from_file(filename)
      sst = SlideshowType.find(self.slideshow_type_id)
      sst.slide_width  = geometry.width
      sst.slide_height = geometry.height
      sst.save
    end

  end
end
