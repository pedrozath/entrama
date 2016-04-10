# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick
    storage :file

    def default_url(*args)
        ActionController::Base.helpers.asset_path("fallback-product.jpg")
    end

    def store_dir
        "uploads/images/#{model.id}"
    end

    version :thumb do
        process resize_to_fit: [100,100]
    end


end
