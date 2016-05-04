# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
    storage :fog
    version :thumb do
        process resize_to_fit: [100,100]
    end

    version :small do
        process resize_to_fit: [200,200]
    end

    version :medium do
        process resize_to_fit: [500,500]
    end

    version :big do
        process resize_to_fit: [800,800]
    end

    version :larger do
        process resize_to_fit: [1200,1200]
    end

end
