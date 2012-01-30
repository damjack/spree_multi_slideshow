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

  #process_in_background :image UTILE MA OCCORRE ATTIVARE ANCHE LA GEMMA DELAYED-PAPERCLIP

  def initialize(*args)
    super(*args)
    last_slide = Slide.last
    self.position = last_slide ? last_slide.position + 1 : 0
  end

end
