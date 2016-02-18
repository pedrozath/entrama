class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    def show
    end

    def update
        @product = Product.find params[:id]
        # Product.where({
        #     @product.
        # })
 
        # @main_attributes = Product.first.attributes
        # @main_attributes.delete("id")
        # @main_attributes.delete("created_at")
        # @main_attributes.delete("updated_at")
        # @main_attributes.delete("price")
        # @main_attributes.delete("quantity")
        # @main_attributes[params[:field]] = params[:value]

        # puts @main_attributes

        # @duplicated_products = Product.where(@main_attributes)

        # if @duplicated_products.size > 0
        #     for duplicated_product in @duplicated_products
        #         # puts @product.quantity, @product.quantity.class, @product.quantity.to_i, duplicated_product.quantity
        #         @product.quantity = @product.quantity.to_i + duplicated_product.quantity.to_i
        #         # puts @product.quantity
        #         # duplicated_product.destroy
        #     end
        #     @product.save
        # else
        # end

        @product.update_attribute params[:field], params[:value].strip
        render nothing: true, status: :accepted
    end

    def create
        @collection = Collection.find params[:collection_id]
        @product = @collection.products.new params[:product].permit(:size,:garb_type,:fabric,:color,:quantity,:price)

        if @product.valid?
            puts @product.save

            if params[:product].include? :image
                @image = Image.create file: params[:product][:image]
            else
                @image = Image.find params[:product][:use_existing_image]
            end

            @product.create_icon image_id: @image.id

        end

        render controller: "collections", action: "show"
    end

    def destroy
        Product.find(params[:id]).destroy
        redirect_to :back
    end
end