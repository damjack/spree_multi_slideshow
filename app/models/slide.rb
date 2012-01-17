class Slide < ActiveRecord::Base
  belongs_to :slideable, :polymorphic => true
  
  has_attached_file :image,
            :url  => "/assets/slides/:id/:style_:basename.:extension",
            :path => ":rails_root/public/assets/slides/:id/:style_:basename.:extension",
            #:default_url => "/missing/:style.jpg",
            :styles => {
                  :thumbnail => "100x33#",
                  :small => "300x100#",
                  :medium => "600x200#",
                  :slide => "900x300#",
                  :custom => Proc.new { |instance| "#{instance.width}x#{instance.height}#" }
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
    last_page = Page.last
    self.position = last_page ? last_page.position + 1 : 0
  end

end
