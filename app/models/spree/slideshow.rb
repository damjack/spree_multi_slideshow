module Spree
  class Slideshow < ActiveRecord::Base
    has_many :slides
    
    attr_accessible :category, :enable_navigation, :enabled
    
    validates :category, :presence => true
    validates_uniqueness_of :category

    scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }
  end
end
