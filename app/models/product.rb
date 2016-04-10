class Product < ActiveRecord::Base
    belongs_to :collection, counter_cache: true
    has_one :icon
    has_many :photos
    has_many :order_products
    has_many :orders, through: :order_products
    attr_accessor :use_existing_image, :image
    attr_accessor :icon_image

    # validates :size, :garb_type, :fabric, :color, 
    # :quantity, :price, presence: true

    # # validates :icon, presence: true, unless: -> (p){p.use_existing_image.present?}
    # validates :use_existing_image, presence: true, if: "image.nil?"

    before_destroy :destroy_associated

    def icon_image(version=nil)
        if self.icon
            self.icon.image.file.url version
        else
            ActionController::Base.helpers.asset_path("product-fallback.jpg")
        end
    end

    def thumb
        icon_image :thumb
    end

    def formatted_price
        ActionController::Base.helpers.number_to_currency price
    end

    def title
        [collection.title,id,garb_type,fabric,size].join "-"
    end

    private

    def destroy_associated
        self.icon.delete if self.icon
        self.photos.delete_all
    end


end
