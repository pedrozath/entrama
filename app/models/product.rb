class Product < ActiveRecord::Base
    belongs_to :collection
    has_one :icon
    has_many :photos
    has_many :order_products
    has_many :orders, through: :order_products
    attr_accessor :use_existing_image

    validates :size, :garb_type, :fabric, :color, 
    :quantity, :price, presence: true

    validates :icon, presence: true, unless: ->(p){p.use_existing_image.present?}
    validates :use_existing_image, presence: true, unless: ->(p){p.icon.present?}
end
