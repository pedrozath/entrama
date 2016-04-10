class ProductsController < ApplicationController
    def index
        @products = Product.order(:created_at)
        respond_to do |f|
            f.json { render json: @products.all.as_json(methods: [:icon_image], include: :collection), status: :ok }
            f.html { }
        end
    end

    def show
        @product = Product.find params[:id]
        respond_to do |f|
            f.json do  
                render json: @product.as_json(methods: [:icon_image, :formatted_price], include: {
                    collection: {
                        include: { 
                            different_products: {
                                methods: :thumb
                            }
                        }
                    }
                })
            end

            f.html { }
        end     
    end

    def update
        @product = Product.find params[:id]
        
        if params[:field] == "collection"
            @product.collection = Collection.find_or_create_by title: params[:value].strip
            @product.save
            Collection.all.each do |c|
                Collection.reset_counters c.id, :products
            end
        elsif params[:field] == "icon"
            @product.icon.destroy if @product.icon
            @product.create_icon image_id: params[:value]
            @product.save
        else
            @product.update_attribute params[:field], params[:value].strip
        end

        render nothing: true, status: :accepted

    end

    def create
        permitted_params = params[:product].permit(:size,:garb_type,:fabric,:color,:quantity,:price,:image)
        if params.include? :collection_id
            @collection = Collection.find params[:collection_id]
            @product = @collection.products.new permitted_params
        else
            @product = Product.new permitted_params
        end

        if @product.valid?
            @product.save

            if params[:product].include? :image
                @image = Image.create file: params[:product][:image]
            elsif params[:product].include? :use_existing_image
                @image = Image.find params[:product][:use_existing_image]
            end
            
            if @image
                @product.create_icon image_id: @image.id
            end

        end

        respond_to do |f|
            f.html { render "collections/show" }
            f.js { render nothing: true, status: :created }
        end
    end

    def edit_icon
        @product = Product.find params[:id]
    end

    def destroy
        Product.find(params[:id]).destroy
        redirect_to :back
    end
end