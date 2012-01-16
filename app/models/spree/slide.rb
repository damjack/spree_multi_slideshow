class Spree::Slide < ActiveRecord::Base
  belongs_to :slideable, :polymorphic => true

  validate :no_image_errors
  has_attached_file :image,
                :url  => "/assets/slides/:id/:style_:basename.:extension",
                :path => ":rails_root/public/assets/slides/:id/:style_:basename.:extension",
                :default_url => "/missing/:style.jpg",
	              :styles => {:thumbnail => "-gravity center 100x50#", :small => "150x100#", :slide => "" },
	              :convert_options => {:thumbnail => "-gravity Center", :slide => "-gravity Center"}

  #process_in_background :image UTILE MA OCCORRE ATTIVARE ANCHE LA GEMMA DELAYED-PAPERCLIP
  
end
