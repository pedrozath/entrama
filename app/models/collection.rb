class Collection < ActiveRecord::Base
    belongs_to :element
    has_many :products
    has_many :icons, through: :products
    has_many :photos, through: :products
    has_many :orders, through: :products

    def icon
        display_product.icon
    end

    def display_product
        self.products.first
    end
end
