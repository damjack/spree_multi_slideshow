class SlideshowType < ActiveRecord::Base

  has_many :slides, :as => :slideable

  validates :category, :slide_number, :width, :presence => true
  validates_numericality_of :slide_number, :only_integer => true
  
  scope :with_states, lambda { |*states| {:conditions => {:state => states}} }
  scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }

  def initialize(*args)
    super(*args)
  end

end
