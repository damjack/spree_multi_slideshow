class SlideshowType < ActiveRecord::Base
  has_many :slides
  after_update :reprocess_slides
  
  attr_accessible :category, :slide_width, :slide_height, :slide_number, :enable_navigation, :enabled, :enable_pagination
  
  validates :slide_number, :slide_width, :slide_height, :presence => true
  validates_uniqueness_of :category
  validates_numericality_of :slide_number, :only_integer => true
  
  scope :enable, where("enabled IS NOT NULL AND enabled = 1")
  
  def reprocess_slides
    self.slides.each do |slide|
      slide.attachment_width = self.slide_width
      slide.attachment_height = self.slide_height
      slide.save!
      slide.attachment.reprocess!(:custom)
    end
  end
end
