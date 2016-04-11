# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
    storage :fog
    version :thumb do
        process resize_to_fit: [100,100]
    end

end
