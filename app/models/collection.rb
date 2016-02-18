class Collection < ActiveRecord::Base
    belongs_to :element
    has_many :products
    has_many :icons, through: :products
    has_many :photos, through: :products
    has_many :orders, through: :products
end
