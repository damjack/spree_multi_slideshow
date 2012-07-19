class Slide < ActiveRecord::Base
  has_many :slideshow_types
  
  attr_accessor :attachment_width, :attachment_height
  attr_accessible :title, :url, :slideshow_type_id, :attachment, :attachment_width, :attachment_height
  
  has_attached_file :attachment,
            :url  => "/spree/slides/:id/:style_:basename.:extension",
            :path => ":rails_root/public/spree/slides/:id/:style_:basename.:extension",
            #:default_url => "/missing/:style.jpg",
            :styles => {
                  :thumbnail => "100x33#",
                  :small => "300x100#",
                  :medium => "600x200#",
                  :slide => "900x300#",
                  :custom => Proc.new {|instance| "#{instance.attachment_width}x#{instance.attachment_height}#"}
            },
            :convert_options => {
                  :thumbnail => "-gravity center",
                  :small => "-gravity center",
                  :medium => "-gravity center",
                  :slide => "-gravity center",
                  :custom => "-gravity center"
            }

  validates_presence_of :slideshow_type_id
  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/jpg', 'image/x-png', 'image/pjpeg'], :message => "deve essere JPG, JPEG, PNG o GIF"

  def initialize(*args)
    super(*args)
    last_slide = Slide.last
    self.position = last_slide ? last_slide.position + 1 : 0
  end

end
