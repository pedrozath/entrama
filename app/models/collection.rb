class Collection < ActiveRecord::Base
    belongs_to :element
    has_many :images, as: :imageable
    has_many :product
    has_many :orders, through: :product
end
