class ImagesController < ApplicationController
    def destroy
        image = Image.find params[:id]
        image.destroy
        render nothing: true
    end
    def create
        Image.create file: params[:file]
        render nothing: true
    end
end