Spree::Taxon.class_eval do
  has_many :slides, :as => :slideable
end