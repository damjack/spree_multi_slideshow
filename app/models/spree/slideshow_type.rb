module Spree
  class SlideshowType < ActiveRecord::Base

    belongs_to :slide

    validates :slide_number, :slide_width, :slide_height, :presence => true
    validates_uniqueness_of :category
    validates_numericality_of :slide_number, :only_integer => true

    scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }

    def initialize(*args)
      super(*args)
    end

  end
end
