class ProductsController < ApplicationController
    before_filter :authorize, :only => [:update, :create, :edit_icon, :destroy]
    
    def index
        respond_to do |f|
            f.json do 
                @products = Product.by_icon
                render json: @products.as_json(methods: [:icon_image, :icon_image_big, :thumb], include: {
                    collection: {
                        methods: [:art_image, :thumb]
                    }
                })
            end
            f.html do 
                @facebook_meta_tags.merge({
                    
                })
                @products = Product.by_collection.unique
            end
        end
    end

    def stock
    end

    def show
        @product = Product.find params[:id]
        @collection = @product.collection

        respond_to do |f|
            f.json do  
                render json: @product.as_json(
                    methods: [:icon_image, :icon_image_big, :formatted_price, :available_sizes], include: {
                        collection: {
                            methods: [:art_image],
                            include: { 
                                different_products: {
                                    methods: [:thumb]
                                }
                            }
                        }
                })
            end

            f.html { 
                @facebook_meta_tags[:image] = @product.icon_image(:medium)
                @facebook_meta_tags[:title] = "Camiseta #{@product.collection.title}"
                render template: "collections/show"
            }
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
        elsif params[:field] == "color"
            @product.similar_products.each {|p| p.update_attribute params[:field], params[:value].strip}
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