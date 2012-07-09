module Spree
  class SlideshowType < ActiveRecord::Base
    has_many :slides
    
    attr_accessible :category, :enabled, :slide_height, :slide_width, :slide_number, :enable_navigation

    validates :slide_number, :slide_width, :slide_height, :presence => true
    validates_uniqueness_of :category
    validates_numericality_of :slide_number, :only_integer => true

    scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }

    def initialize(*args)
      super(*args)
    end

  end
end
