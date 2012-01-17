class SlideshowType < ActiveRecord::Base

  belongs_to :slide

  validates :category, :slide_number, :slide_width, :slide_height, :presence => true
  validates_numericality_of :slide_number, :only_integer => true
  
  scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }

  def initialize(*args)
    super(*args)
  end

end
