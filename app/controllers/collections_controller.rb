class CollectionsController < ApplicationController
    before_filter :authorize, :only => [:update, :create, :destroy, :edit_art]

    def index
        @collections = Collection.where("products_count > 0").includes(art:[:image])
    end

    def show
        @collection ||= Collection.find params[:id]
        @product = @collection.display_product
    end

    def update
        @collection = Collection.find params[:id]
        if params[:field] == "art"
            @collection.art.destroy if @collection.art
            @collection.create_art image_id: params[:value]
        else
            @collection.update_attribute params[:field], params[:value]
        end
        render text: params
    end

    def create
        collection = Collection.create params[:collection].permit(:title,:price,:description)
        redirect_to :back
    end

    def destroy
        Collection.find(params[:id]).destroy
        redirect_to :back
    end

    def edit_art
        @collection = Collection.find params[:id]
    end
end
