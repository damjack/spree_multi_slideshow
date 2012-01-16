class Spree::SlideshowType < ActiveRecord::Base
  
  has_many :slide, :as => :slideable
  
  validates :name, :slide_number, :width, :presence => true
  validates_numericality_of :slide_number, :only_integer => true

  scope :enable, :conditions => ["enabled = ?", true]
  
end
