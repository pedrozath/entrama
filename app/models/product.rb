class Product < ActiveRecord::Base
    belongs_to :collection
    has_one :icon
    has_many :photos
    has_many :order_products
    has_many :orders, through: :order_products
    attr_accessor :use_existing_image, :image

    validates :size, :garb_type, :fabric, :color, 
    :quantity, :price, presence: true

    # validates :icon, presence: true, unless: -> (p){p.use_existing_image.present?}
    validates :use_existing_image, presence: true, if: "image.nil?"

    before_destroy :destroy_associated

    private

    def destroy_associated
        self.icons.delete_all
        self.photos.delete_all
    end

end
