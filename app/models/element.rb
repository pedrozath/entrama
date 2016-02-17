class Element < ActiveRecord::Base
    has_many :images, as: :imageable
    has_many :collections
end