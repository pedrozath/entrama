class Product < ActiveRecord::Base
    belongs_to :collection
    has_many :images, as: :imageable
    has_many :order_products
    has_many :orders, through: :order_products
end
