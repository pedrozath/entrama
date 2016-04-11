class Collection < ActiveRecord::Base
    belongs_to :element
    has_many :products
    has_many :icons, through: :products
    has_many :photos, through: :products
    has_many :orders, through: :products

    has_one :art

    def icon
        display_product.icon
    end

    def icon_image
        display_product.icon_image
    end

    def display_product
        products.first
    end

    def sizes
        sizes = products.collect(&:size).compact.uniq
    end

    def colors
        products.collect(&:color).compact.uniq
    end

    def icons(version=nil)
        products.map{|p| p.icon_image version}.uniq
    end

    def different_products
        products.inject([]) do |memo, p|
            if !memo.map{|m|m.icon_image}.include?(p.icon_image)
                memo << p
            end
            memo
        end
    end

    def thumbs
        icons :thumb
    end

    def art_image(version=nil)
        if art
            art.image.file.url(version)
        else
            ActionController::Base.helpers.asset_path("product-fallback.jpg")
        end
    end

    def thumb
        art_image :thumb
    end
end
