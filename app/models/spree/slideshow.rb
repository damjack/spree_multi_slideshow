module Spree
  class Slideshow < ActiveRecord::Base
    has_many :slides
    
    attr_accessible :category, :enable_navigation, :enable_pagination, :enabled, :mode, :auto_start, :infinite_loop,
                    :hide_control_on_end
    
    validates :category, :presence => true
    validates_uniqueness_of :category

    scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }
    
    def mode_enum
      [["Orizzontale", "horizontal"], ["Dissolvenza", "fade"], ["Verticale", "vertical"]]
    end
  end
end
