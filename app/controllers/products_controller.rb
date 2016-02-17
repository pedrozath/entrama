class ProductsController < ApplicationController
    def index
    end

    def show
        @product = Product.find params[:id]
    end

    def update
        @product = Product.find params[:id]
        @product.update_attribute params[:field], params[:value]
        render text: params
        # @product.update_attributes params
    end

    def create
        product = Product.create params[:product].permit(:title,:quantity,:price,:description)
        for picture in params[:product][:images] do 
            ProductImage.create path: picture, product: product
        end
        redirect_to :back
    end

    def destroy
        Product.find(params[:id]).destroy
        redirect_to :back
    end
end