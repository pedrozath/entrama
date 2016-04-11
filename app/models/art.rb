class Art < ActiveRecord::Base
    belongs_to :image
    belongs_to :collection
end
