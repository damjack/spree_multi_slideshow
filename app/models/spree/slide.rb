module Spree
  class Slide < ActiveRecord::Base
    belongs_to :slideshow_type
    
    attr_accessor :attachment_width, :attachment_height
    attr_accessible :title, :url, :attachment_width, :attachment_height, :content, :slideshow_type_id, :attachment
    
    has_attached_file :attachment,
            :url  => "/spree/slides/:id/:style_:basename.:extension",
            :path => ":rails_root/public/spree/slides/:id/:style_:basename.:extension",
            :styles => lambda {|a|
              {
                  :thumbnail => "100x33#",
                  :small =>  "300x100#",
                  :medium => "600x200#",
                  :slide =>  "900x300#",
                  :custom => "#{a.instance.attachment_width}x#{a.instance.attachment_height}#"
              }
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
    
    # Load S3 settings
    if ( FileTest.exist?(Rails.root.join('config', 's3.yml')) && !YAML.load_file(Rails.root.join('config', 's3.yml'))[Rails.env].blank?)
      S3_OPTIONS = {
              :storage => 's3',
              :s3_credentials => Rails.root.join('config', 's3.yml')
            }
    elsif (FileTest.exist?(Rails.root.join('config', 's3.yml')) &&!ENV['S3_KEY'].blank? && !ENV['S3_SECRET'].blank? && !ENV['S3_BUCKET'].blank?)
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
    
    attachment_definitions[:attachment] = (attachment_definitions[:attachment] || {}).merge(S3_OPTIONS)
    
    def initialize(*args)
      super(*args)
      last_slide = Slide.last
      self.position = last_slide ? last_slide.position + 1 : 0
    end

  end
end
