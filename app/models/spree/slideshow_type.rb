module Spree
  class SlideshowType < ActiveRecord::Base
    has_many :slides
    
    attr_accessible :category, :enable_navigation, :enabled, :enable_pagination
    
    validates :category, :presence => true
    validates_uniqueness_of :category
    
    scope :enable, lambda { |category| {:conditions => {:enabled => true, :category => category}} }
  end
end
