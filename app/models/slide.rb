class Slide < ActiveRecord::Base
  belongs_to :slideable, :polymorphic => true

  validate :no_image_errors
  has_attached_file :image,
  :url  => "/assets/slides/:id/:style_:basename.:extension",
  :path => ":rails_root/public/assets/slides/:id/:style_:basename.:extension",
  #:default_url => "/missing/:style.jpg",
  :styles => {
      :thumbnail => "-gravity center 100x33#",
      :small => "-gravity center 300x100#",
      :medium => "-gravity center 600x200#",
      :slide => "-gravity center 900x300#",
      :custom => Proc.new { |instance| "#{instance.width}x#{instance.height}#" }
      },
  :convert_options => {:thumbnail => "-gravity Center", :slide => "-gravity Center"}

  #process_in_background :image UTILE MA OCCORRE ATTIVARE ANCHE LA GEMMA DELAYED-PAPERCLIP

  def initialize(*args)
    super(*args)
    last_page = Page.last
    self.position = last_page ? last_page.position + 1 : 0
  end

end
