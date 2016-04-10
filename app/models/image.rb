class Image < ActiveRecord::Base
    has_many :icons, dependent: :destroy
    has_many :photos
    mount_uploader :file, ImageUploader

    validates :file, presence: true
end
