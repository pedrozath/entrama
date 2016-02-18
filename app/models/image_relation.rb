class ImageRelation < ActiveRecord::Base
    belongs_to :imageable, polymorphic: true
    belongs_to :element
    belongs_to :product
    belongs_to :image
end