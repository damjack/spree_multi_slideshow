# This is the primary location for defining spree slideshow preferences
#
Spree::AppConfiguration.class_eval do
    # Preferences related to slide settings
    preference :slide_default_url, :string, :default => '/spree/slides/:id/:style/:basename.:extension'
    preference :slide_path, :string, :default => ':rails_root/public/spree/slides/:id/:style/:basename.:extension'
    preference :slide_url, :string, :default => '/spree/slides/:id/:style/:basename.:extension'
    preference :slide_styles, :string, :default => "{\"mini\":\"60x60#\",\"small\":\"300x100#\",\"medium\":\"600x200#\",\"large\":\"900x300#\"}"
    preference :slide_default_style, :string, :default => 'medium'
end
