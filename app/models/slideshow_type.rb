class SlideshowType < ActiveRecord::Base
  has_many :slides
  
  attr_accessible :category, :slide_width, :slide_height, :slide_number, :enable_navigation, :enabled
  
  validates :slide_number, :slide_width, :slide_height, :presence => true
  validates_uniqueness_of :category
  validates_numericality_of :slide_number, :only_integer => true
  
  scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }
end
